import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:flutter_news/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_news/features/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_news/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._removeArticleUseCase,
    this._saveArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticle>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  Future<void> onGetSavedArticles(
    GetSavedArticle event,
    Emitter<LocalArticleState> emit,
  ) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  Future<void> onRemoveArticle(
    RemoveArticle event,
    Emitter<LocalArticleState> emit,
  ) async {
    await _removeArticleUseCase(params: event.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  Future<void> onSaveArticle(
    SaveArticle event,
    Emitter<LocalArticleState> emit,
  ) async {
    await _saveArticleUseCase(params: event.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }
}
