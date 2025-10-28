import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/my_image.dart';

sealed class LoadImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ImageNotLoadedState extends LoadImageState {}

final class ImageLoadingState extends LoadImageState {}

final class ImageLoadedState extends LoadImageState {
  final List<MyImage> allImages;
  ImageLoadedState({required this.allImages});

  @override
  List<Object?> get props => [allImages];
}
