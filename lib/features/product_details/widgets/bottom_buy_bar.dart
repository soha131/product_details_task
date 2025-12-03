import 'package:flutter/material.dart';

class BottomBuyBar extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback? onDecrease;

  const BottomBuyBar({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE7E00),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Buy Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                _quantityBtn(Icons.remove, onDecrease),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('$quantity', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                _quantityBtn(Icons.add, onIncrease),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _quantityBtn(IconData icon, VoidCallback? onPressed) {
    final isDisabled = onPressed == null;

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (!isDisabled)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDisabled ? Colors.grey.shade400 : Colors.black,
        ),
      ),
    );
  }

}