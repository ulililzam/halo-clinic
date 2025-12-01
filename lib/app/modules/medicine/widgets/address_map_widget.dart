import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class AddressMapWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final Function(double lat, double lng, String address)? onLocationSelected;

  const AddressMapWidget({
    super.key,
    this.latitude,
    this.longitude,
    this.onLocationSelected,
  });

  @override
  State<AddressMapWidget> createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> {
  double? selectedLat;
  double? selectedLng;

  @override
  void initState() {
    super.initState();
    selectedLat = widget.latitude;
    selectedLng = widget.longitude;
  }

  void _onMapTap(TapUpDetails details) {
    // Simulasi: Convert tap position ke koordinat
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = details.localPosition;
    
    // Dummy calculation untuk demo
    selectedLat = -7.0511 + (localPosition.dy / box.size.height) * 0.01;
    selectedLng = 110.3606 + (localPosition.dx / box.size.width) * 0.01;
    
    setState(() {});
    
    // Simulasi reverse geocoding
    final mockAddress = 'Jl. Bukit Beringin Asri IV 421-418, Gondoriyo, Kec. Ngaliyan, Kota Semarang, Jawa Tengah, Indonesia';
    
    widget.onLocationSelected?.call(
      selectedLat!,
      selectedLng!,
      mockAddress,
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _onMapTap,
      child: Container(
        color: Colors.grey[200],
        child: Stack(
          children: [
            // Placeholder untuk Google Maps
            // TODO: Implement Google Maps
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 60,
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ketuk peta untuk pilih lokasi',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (selectedLat != null && selectedLng != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Lat: ${selectedLat!.toStringAsFixed(4)}, Lng: ${selectedLng!.toStringAsFixed(4)}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Pin marker di center
            if (selectedLat != null && selectedLng != null)
              Center(
                child: Icon(
                  Icons.location_on,
                  size: 48,
                  color: AppColors.error,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            
            // Current Location Button
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.my_location, color: AppColors.primary),
                  onPressed: () {
                    // TODO: Get current location from GPS
                    // For now, use default location
                    setState(() {
                      selectedLat = -7.0511;
                      selectedLng = 110.3606;
                    });
                    
                    widget.onLocationSelected?.call(
                      selectedLat!,
                      selectedLng!,
                      'Jl. Bukit Beringin Asri IV 421-418, Gondoriyo, Kec. Ngaliyan, Kota Semarang, Jawa Tengah, Indonesia',
                    );
                    
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
