import {
    fetchArticles,
    fetchArticle,
    fetchCategories,
    fetchArticlesByCategorie,
    fetchArticlesByAuteur,
    filtrerParTitreOuResume,
} from './api.js';
import {
    renderCategories,
    renderArticleList,
    renderArticle,
    renderLoading,
    renderError,
    setActiveSort,
} from './ui.js';
import type { ArticleResume } from './types.js';

class App {
    private articles: ArticleResume[] = [];
    private sort: string = 'date-desc';
    private loader: (sort: string) => Promise<ArticleResume[]>;
    private titre: string;

    constructor() {
        this.loader = (s) => fetchArticles(s);
        this.titre  = 'Tous les articles';
    }

    async init(): Promise<void> {
        await this.loadCategories();
        await this.loadList(this.loader, this.titre);
        this.bindSortEvents();
        this.bindSearchEvent();

        document.getElementById('home-link')?.addEventListener('click', e => {
            e.preventDefault();
            this.loader = (s) => fetchArticles(s);
            this.titre  = 'Tous les articles';
            this.sort   = 'date-desc';
            this.loadList(this.loader, this.titre);
        });
    }

    private async loadCategories(): Promise<void> {
        try {
            const cats = await fetchCategories();
            renderCategories(cats, (id, libelle) => {
                this.loader = (s) => fetchArticlesByCategorie(id, s);
                this.titre  = `Categorie : ${libelle}`;
                this.loadList(this.loader, this.titre);
            });
        } catch {
            const el = document.getElementById('categories-list');
            if (el) el.innerHTML = '<p class="erreur">Erreur</p>';
        }
    }

    async loadList(
        loader: (sort: string) => Promise<ArticleResume[]>,
        titre: string
    ): Promise<void> {
        this.loader = loader;
        this.titre  = titre;
        renderLoading();
        try {
            this.articles = await loader(this.sort);
            const motCle  = (document.getElementById('search-input') as HTMLInputElement)?.value ?? '';
            const filtered = filtrerParTitreOuResume(this.articles, motCle);
            this.renderList(filtered);
            setActiveSort(this.sort);
        } catch {
            renderError('Impossible de charger les articles.');
        }
    }

    private renderList(articles: ArticleResume[]): void {
        renderArticleList(
            articles,
            this.titre,
            (id) => this.showArticle(id),
            (auteurId, email) => {
                this.loader = (_s) => fetchArticlesByAuteur(auteurId);
                this.titre  = `Articles de ${email}`;
                this.loadList(this.loader, this.titre);
            }
        );
    }

    private async showArticle(id: number): Promise<void> {
        renderLoading();
        try {
            const article = await fetchArticle(id);
            renderArticle(article, () => this.loadList(this.loader, this.titre));
        } catch {
            renderError('Article introuvable.');
        }
    }

    private bindSortEvents(): void {
        document.querySelectorAll<HTMLElement>('[data-sort]').forEach(el => {
            el.addEventListener('click', () => {
                this.sort = el.dataset.sort!;
                this.loadList(this.loader, this.titre);
            });
        });
    }

    private bindSearchEvent(): void {
        document.getElementById('search-input')?.addEventListener('input', () => {
            const motCle   = (document.getElementById('search-input') as HTMLInputElement).value;
            const filtered = filtrerParTitreOuResume(this.articles, motCle);
            this.renderList(filtered);
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const app = new App();
    app.init().catch(console.error);
});
