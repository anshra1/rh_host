class AppDrawerItem extends StatelessWidget {
  const AppDrawerItem({
    required this.title,
    this.icon,
    this.onTap,
    this.selected = false,
    super.key,
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: selected ? AppColors.primaryColor : AppColors.textSecondary,
            )
          : null,
      title: Text(
        title,
        style: AppFonts.bodyMedium.copyWith(
          color: selected ? AppColors.primaryColor : AppColors.textPrimary,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.selectedOverlay,
      onTap: onTap,
    );
  }
}
