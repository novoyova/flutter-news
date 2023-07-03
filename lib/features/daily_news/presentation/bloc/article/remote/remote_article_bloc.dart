import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/core/resources/data_state.dart';
import 'package:flutter_news/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_news/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_news/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      debugPrint('SUCCESS: ${dataState.data!}');
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      debugPrint('ERROR: ${dataState.error!.message}');
      emit(RemoteArticleError(dataState.error!));
    }
  }
}
