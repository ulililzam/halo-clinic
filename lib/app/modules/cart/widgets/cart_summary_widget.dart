import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';
import 'package:intl/intl.dart';

class CartSummaryWidget extends StatelessWidget {
  final int subTotal;
  final int shippingCost;
  final int promoDiscount;
  final int total;

  const CartSummaryWidget({
    super.key,
    required this.subTotal,
    required this.shippingCost,
    required this.promoDiscount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Sub Total
          _buildRow(
            'Sub Total',
            currencyFormatter.format(subTotal),
            isLight: true,
          ),
          const SizedBox(height: 12),

          // Pengiriman
          _buildRow(
            'Pengiriman',
            shippingCost == 0 ? 'Rp0' : currencyFormatter.format(shippingCost),
            isLight: true,
          ),
          const SizedBox(height: 12),

          // Promo
          _buildRow(
            'Promo',
            promoDiscount == 0 ? '-Rp0' : '-${currencyFormatter.format(promoDiscount)}',
            isLight: true,
          ),
          const SizedBox(height: 16),

          // Divider
          Divider(
            color: Colors.grey[300],
            height: 1,
          ),
          const SizedBox(height: 16),

          // Total
          _buildRow(
            'Total',
            currencyFormatter.format(total),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isLight = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isLight ? AppColors.textSecondary : AppColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
