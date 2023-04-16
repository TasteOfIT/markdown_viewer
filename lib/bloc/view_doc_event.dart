part of 'view_doc_bloc.dart';

abstract class ViewDocEvent extends Equatable {
  const ViewDocEvent();
}

class LoadDoc extends ViewDocEvent {
  const LoadDoc(this.id) : super();

  final String id;

  @override
  List<Object?> get props => [id];
}
