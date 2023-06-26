part of 'add_button_cubit.dart';

class AddButtonState extends Equatable {
  final bool isAdd;
  const AddButtonState(
    this.isAdd,
  );
  factory AddButtonState.initial() => const AddButtonState(false);

  AddButtonState copyWith({
    bool? isAdd,
  }) {
    return AddButtonState(
      isAdd ?? this.isAdd,
    );
  }

  @override
  List<Object?> get props => [isAdd];
}
