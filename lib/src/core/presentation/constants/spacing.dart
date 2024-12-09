import 'package:gap/gap.dart';
import 'package:rh_host/src/core/presentation/constants/design_system.dart';

class Spacing {
  const Spacing._();

  static const Gap zero = Gap(0);
  static const Gap xs = Gap(DesignSystem.spacing_xs);
  static const Gap sm = Gap(DesignSystem.spacing_sm);
  static const Gap md = Gap(DesignSystem.spacing_md);
  static const Gap lg = Gap(DesignSystem.spacing_lg);
  static const Gap xl = Gap(DesignSystem.spacing_xl);
  static const Gap xxl = Gap(DesignSystem.spacing_xxl);
}
