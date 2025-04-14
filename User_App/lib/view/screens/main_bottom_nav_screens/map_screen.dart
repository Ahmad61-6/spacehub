import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spacehub/controllers/map_controller.dart';
import 'package:spacehub/controllers/work_space_controller.dart';
import 'package:spacehub/view/screens/work_space_details_screen.dart';
import 'package:spacehub/view/utility/assets_path.dart';
import 'package:spacehub/view/widgets/details_screen_carousel.dart';

import '../../../core/models/work_space_model.dart';
import '../../utility/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  final Set<Marker> _markers = {};
  late GoogleMapController mapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection('workspaces');

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _setupMarkers();
    Get.find<WorkspaceController>().fetchAllWorkspaces();
  }

  Future<void> _loadCustomMarker() async {
    try {
      // Smaller marker size (24x24 pixels)
      customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        AssetsPath.mapMarker,
      );
    } catch (e) {
      print("Error loading custom marker: $e");
      customIcon = BitmapDescriptor.defaultMarker;
    }
  }

  void _setupMarkers() {
    placeCollection.snapshots().listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final newMarkers = <Marker>{};

        for (final doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>?;

          if (data != null &&
              data['location'] != null &&
              data['locationName'] != null) {
            final geoPoint = data['location'] as GeoPoint;
            final position = LatLng(geoPoint.latitude, geoPoint.longitude);

            newMarkers.add(
              Marker(
                markerId: MarkerId(data['locationName']),
                position: position,
                onTap: () {
                  _customInfoWindowController.addInfoWindow!(
                    _buildInfoWindowContent(data),
                    position,
                  );
                },
                icon: customIcon,
              ),
            );
          }
        }

        setState(() {
          _markers.clear();
          _markers.addAll(newMarkers);
        });
      }
    });
  }

  Widget _buildInfoWindowContent(Map<String, dynamic> data) {
    final workspace = Workspace(
      id: data['id']?.toString() ??
          '', // Make sure your Firestore has an 'id' field
      name: data['name']?.toString() ?? 'No Name',
      category: data['category']?.toString() ?? 'private',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: (data['reviews'] as num?)?.toInt() ?? 0,
      location: data['location'] as GeoPoint? ?? const GeoPoint(0, 0),
      locationName: data['locationName']?.toString() ?? 'No Location',
      facilities: List<String>.from(data['facilities'] ?? []),
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      imageUrls: List<String>.from(
          data['imageUrls']?.map((url) => url.toString()) ?? []),
      description: data['description']?.toString(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
    List<String> images = [];
    if (data['imageUrls'] != null) {
      images =
          List<String>.from(data['imageUrls'].map((url) => url.toString()));
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => WorkSpaceDetailsScreen(workspace: workspace));
              _customInfoWindowController.hideInfoWindow!();
            },
            child: DetailsScreenCarousel(
              currentIndex: 0,
              imageUrls: images,
              name: data['name'],
              rating: data['rating'],
              location: data['locationName'],
              price: data['price'],
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          // Text(
          //   data['locationName'] ?? 'No Name',
          //   style: const TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //       color: AppColors.appBackground),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workspaces Map',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.appBackground,
        centerTitle: true,
      ),
      body: GetBuilder<MapController>(
        builder: (controller) {
          if (controller.currentLocation == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.currentLocation!.latitude!,
                    controller.currentLocation!.longitude!,
                  ),
                  zoom: 11,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  _customInfoWindowController.googleMapController = controller;
                },
                onTap: (position) {
                  _customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: MediaQuery.of(context).size.width * 0.78,
                width: MediaQuery.of(context).size.width * 0.85,
                offset: 50,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }
}
