part of sales_widgets;

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryTitle,
    required this.itemsTotal,
    required this.color,
  });

  final String categoryTitle;
  final int itemsTotal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 170,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.card_giftcard),
            Wrap(
              direction: Axis.vertical,
              children: [
                Text(
                  categoryTitle,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text('$itemsTotal Items'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
