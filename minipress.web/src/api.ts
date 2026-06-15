import type { Article, ArticleResume, Categorie } from './types.js';

const API = '/api';

async function get<T>(url: string): Promise<T> {
    const res = await fetch(url);
    if (!res.ok) throw new Error(`Erreur HTTP ${res.status}`);
    return res.json() as Promise<T>;
}

export async function fetchCategories(): Promise<Categorie[]> {
    return get<Categorie[]>(`${API}/categories`);
}

export async function fetchArticles(_sort: string = 'date-desc'): Promise<ArticleResume[]> {
    return get<ArticleResume[]>(`${API}/articles`);
}

export async function fetchArticle(id: number): Promise<Article> {
    return get<Article>(`${API}/articles/${id}`);
}

export async function fetchArticlesByCategorie(id: number, _sort: string = 'date-desc'): Promise<ArticleResume[]> {
    return get<ArticleResume[]>(`${API}/categories/${id}/articles`);
}

export async function fetchArticlesByAuteur(id: number): Promise<ArticleResume[]> {
    return get<ArticleResume[]>(`${API}/auteurs/${id}/articles`);
}