part of 'search_results_cubit.dart';

enum MovieStatus {
  initial,
  loading,
  loaded,
  adding,
  error,
  allfetched,
}

enum PeopleStatus {
  initial,
  loading,
  loaded,
  adding,
  error,
  allfetched,
}

class SearchResultsState {
  final int moviePage;

  final int peoplePage;
  final bool moviesFull;

  final bool peopleFull;
  final String query;
  final MovieStatus movieStatus;
  final PeopleStatus peopleStatus;

  final List<Movie> movies;

  final List<PeopleModel> people;
  SearchResultsState({
    required this.moviePage,
    required this.peoplePage,
    required this.moviesFull,
    required this.peopleFull,
    required this.query,
    required this.movieStatus,
    required this.peopleStatus,
    required this.movies,
    required this.people,
  });
  factory SearchResultsState.initial() => SearchResultsState(
        moviePage: 1,
        movieStatus: MovieStatus.initial,
        moviesFull: false,
        peopleFull: false,
        movies: [],
        people: [],
        peoplePage: 1,
        peopleStatus: PeopleStatus.initial,
        query: '',
      );

  SearchResultsState copyWith({
    int? moviePage,
    int? peoplePage,
    bool? moviesFull,
    bool? peopleFull,
    String? query,
    MovieStatus? movieStatus,
    PeopleStatus? peopleStatus,
    List<Movie>? movies,
    List<PeopleModel>? people,
  }) {
    return SearchResultsState(
      moviePage: moviePage ?? this.moviePage,
      peoplePage: peoplePage ?? this.peoplePage,
      moviesFull: moviesFull ?? this.moviesFull,
      peopleFull: peopleFull ?? this.peopleFull,
      query: query ?? this.query,
      movieStatus: movieStatus ?? this.movieStatus,
      peopleStatus: peopleStatus ?? this.peopleStatus,
      movies: movies ?? this.movies,
      people: people ?? this.people,
    );
  }
}
