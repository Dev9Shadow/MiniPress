import type { Article, ArticleResume, Categorie } from './types.js';

export function renderCategories(
    _categories: Categorie[],
    _onSelect: (id: number, libelle: string) => void
): void {
    throw new Error('Non implemente');
}

export function renderArticleList(
    _articles: ArticleResume[],
    _titre: string,
    _onArticle: (id: number) => void,
    _onAuteur: (id: number, email: string) => void
): void {
    throw new Error('Non implemente');
}

export function renderArticle(_article: Article, _onBack: () => void): void {
    throw new Error('Non implemente');
}

export function renderLoading(): void {
    const el = document.getElementById('main-content');
    if (el) el.innerHTML = '<p class="chargement">Chargement...</p>';
}

export function renderError(msg: string): void {
    const el = document.getElementById('main-content');
    if (el) el.innerHTML = `<p class="erreur">${msg}</p>`;
}

export function setActiveSort(_sort: string): void {}
