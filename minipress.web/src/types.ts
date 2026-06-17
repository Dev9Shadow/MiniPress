export interface Auteur {
    id: number;
    email: string;
}

export interface Categorie {
    id: number;
    libelle: string;
    href: string;
}

export interface ArticleResume {
    id: number;
    titre: string;
    resume: string | null;
    date_creation: string;
    auteur: Auteur;
    href: string;
}

export interface Article {
    id: number;
    titre: string;
    resume: string | null;
    contenu: string;
    image: string | null;
    date_creation: string;
    auteur: Auteur;
    categorie: Categorie;
}
