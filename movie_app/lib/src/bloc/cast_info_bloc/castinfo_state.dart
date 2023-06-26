part of 'castinfo_bloc.dart';

abstract class CastinfoState extends Equatable {
  const CastinfoState();

  @override
  List<Object> get props => [];
}

class CastinfoInitial extends CastinfoState {}

class CastinfoLoaded extends CastinfoState {
  final CastPersonalInfo info;
  final List<ImageBackdrop> images;

  const CastinfoLoaded({
    required this.info,
    required this.images,
  });
}

class CastinfoLoading extends CastinfoState {}

class CastinfoError extends CastinfoState {
  final FetchDataError error;
  const CastinfoError({
    required this.error,
  });
}
