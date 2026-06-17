import Handlebars from 'handlebars';
import { marked } from 'marked';
import type { Article, ArticleResume, Categorie } from './types.js';

Handlebars.registerHelper('formatDate', (dateStr: string): string => {
    return new Date(dateStr).toLocaleDateString('fr-FR', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });
});

function tpl(id: string): Handlebars.TemplateDelegate {
    const el = document.getElementById(id) as HTMLScriptElement | null;
    if (!el) throw new Error(`Template #${id} introuvable`);
    return Handlebars.compile(el.innerHTML);
}

export function renderCategories(
    categories: Categorie[],
    onSelect: (id: number, libelle: string) => void
): void {
    const container = document.getElementById('categories-list')!;
    container.innerHTML = tpl('tpl-categories')({ categories });
    container.querySelectorAll<HTMLElement>('[data-id]').forEach(el => {
        el.addEventListener('click', e => {
            e.preventDefault();
            onSelect(Number(el.dataset.id), el.dataset.libelle ?? '');
        });
    });
}

export function renderArticleList(
    articles: ArticleResume[],
    titre: string,
    onArticle: (id: number) => void,
    onAuteur: (id: number, email: string) => void
): void {
    const container = document.getElementById('main-content')!;
    container.innerHTML = tpl('tpl-articles')({ articles, titre });

    container.querySelectorAll<HTMLElement>('[data-article-id]').forEach(el => {
        el.addEventListener('click', e => {
            e.preventDefault();
            onArticle(Number(el.dataset.articleId));
        });
    });

    container.querySelectorAll<HTMLElement>('[data-auteur-id]').forEach(el => {
        el.addEventListener('click', e => {
            e.preventDefault();
            e.stopPropagation();
            onAuteur(Number(el.dataset.auteurId), el.dataset.auteurEmail ?? '');
        });
    });
}

export function renderArticle(article: Article, onBack: () => void): void {
    const contenuHtml = marked.parse(article.contenu) as string;
    const resumeHtml  = article.resume ? (marked.parse(article.resume) as string) : '';
    const container   = document.getElementById('main-content')!;
    container.innerHTML = tpl('tpl-article')({ ...article, contenuHtml, resumeHtml });
    container.querySelector('#btn-back')?.addEventListener('click', e => {
        e.preventDefault();
        onBack();
    });
}

export function renderLoading(): void {
    document.getElementById('main-content')!.innerHTML = '<p class="chargement">Chargement...</p>';
}

export function renderError(msg: string): void {
    document.getElementById('main-content')!.innerHTML = `<p class="erreur">${msg}</p>`;
}

export function setActiveSort(sort: string): void {
    document.querySelectorAll<HTMLElement>('[data-sort]').forEach(el => {
        el.classList.toggle('actif', el.dataset.sort === sort);
    });
}
