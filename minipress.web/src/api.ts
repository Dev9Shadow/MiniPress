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

export async function fetchArticles(sort: string = 'date-desc'): Promise<ArticleResume[]> {
    return get<ArticleResume[]>(`${API}/articles?sort=${sort}`);
}

export async function fetchArticle(id: number): Promise<Article> {
    return get<Article>(`${API}/articles/${id}`);
}

export async function fetchArticlesByCategorie(id: number, sort: string = 'date-desc'): Promise<ArticleResume[]> {
    return get<ArticleResume[]>(`${API}/categories/${id}/articles?sort=${sort}`);
}

export async function fetchArticlesByAuteur(id: number): Promise<ArticleResume[]> {
    return get<ArticleResume[]>(`${API}/auteurs/${id}/articles`);
}

export function filtrerParTitre(articles: ArticleResume[], motCle: string): ArticleResume[] {
    if (!motCle.trim()) return articles;
    const kw = motCle.toLowerCase();
    return articles.filter(a => a.titre.toLowerCase().includes(kw));
}

export function filtrerParTitreOuResume(articles: ArticleResume[], motCle: string): ArticleResume[] {
    if (!motCle.trim()) return articles;
    const kw = motCle.toLowerCase();
    return articles.filter(a =>
        a.titre.toLowerCase().includes(kw) ||
        (a.resume?.toLowerCase().includes(kw) ?? false)
    );
}