import 'package:flutter/widgets.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';


class TextStyles {
  static const BorderRadius borderRadius_5 = BorderRadius.all(Radius.circular(5.0));
  static const BorderRadius borderRadius_10 = BorderRadius.all(Radius.circular(10.0));
}

class Decorations {
  static Decoration bottom = BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.33, color: AppColors.divider))
  );
}
/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: AppDimens.gap_5);
  static Widget hGap10 = new SizedBox(width: AppDimens.gap_10);
  static Widget hGap15 = new SizedBox(width: AppDimens.gap_15);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: AppDimens.gap_5);
  static Widget vGap10 = new SizedBox(height: AppDimens.gap_10);
  static Widget vGap15 = new SizedBox(height: AppDimens.gap_15);
}


