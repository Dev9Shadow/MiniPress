-- Jeu de donnees MiniPress
-- Mots de passe hashés avec password_hash(..., PASSWORD_DEFAULT) pour 'admin1234' et 'motdepasse'
SET NAMES utf8mb4;

INSERT INTO `utilisateur` (`id`, `email`, `password`, `role`) VALUES
(1, 'admin@minipress.local',  '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
(2, 'alice@minipress.local',  '$2y$12$qLdVp2g/aY3.E4L8KgBhB.NCJV6kWnhNfF5mA9XjfOCjBe9w7IZeG', 'auteur'),
(3, 'bob@minipress.local',    '$2y$12$qLdVp2g/aY3.E4L8KgBhB.NCJV6kWnhNfF5mA9XjfOCjBe9w7IZeG', 'auteur');

INSERT INTO `categorie` (`id`, `libelle`) VALUES
(1, 'Technologie'),
(2, 'Culture'),
(3, 'Science'),
(4, 'Société');

INSERT INTO `article` (`id`, `titre`, `resume`, `contenu`, `image`, `date_creation`, `publie`, `auteur_id`, `categorie_id`) VALUES
(1,
 'L''essor de l''intelligence artificielle',
 'L''intelligence artificielle transforme en profondeur notre quotidien et nos façons de travailler. Des systèmes capables d''apprendre redéfinissent les frontières du possible dans tous les secteurs d''activité, de la médecine à la finance.',
 'L''intelligence artificielle est devenue une technologie omniprésente dans notre société moderne. Depuis les assistants vocaux jusqu''aux véhicules autonomes, elle s''invite dans chaque aspect de notre quotidien.\n\nLes progrès réalisés ces dernières années sont spectaculaires. Les réseaux de neurones profonds permettent aujourd''hui de résoudre des problèmes qui semblaient insurmontables il y a encore une décennie. La reconnaissance d''images, la traduction automatique et la génération de texte en sont des exemples concrets.\n\nCependant, cette révolution soulève aussi des questions éthiques fondamentales. Comment garantir l''équité des algorithmes ? Comment protéger la vie privée des utilisateurs ? Ces défis appellent une régulation adaptée et une réflexion collective approfondie.',
 NULL, '2025-11-10 09:00:00', 1, 2, 1),

(2,
 'La lecture à l''ère numérique',
 'La révolution numérique a profondément modifié nos habitudes de lecture. Entre liseuses électroniques, applications mobiles et livres audio, les façons de consommer la littérature se multiplient et se diversifient considérablement.',
 'Le livre numérique a connu une progression fulgurante au cours des quinze dernières années. Les liseuses électroniques offrent une expérience de lecture proche du papier, tout en permettant d''emporter des centaines d''ouvrages dans sa poche.\n\nPourtant, le livre papier résiste et conserve une place de choix dans le cœur des lecteurs. De nombreuses études montrent que la lecture sur support physique favorise une meilleure mémorisation et une compréhension plus profonde des textes.\n\nLa coexistence de ces deux formats enrichit finalement l''expérience littéraire. Les lecteurs naviguent aisément entre les supports selon leurs envies et les situations, profitant du meilleur de chaque monde.',
 NULL, '2025-11-20 14:30:00', 1, 3, 2),

(3,
 'Les exoplanètes : à la recherche d''une autre Terre',
 'Depuis la découverte des premières exoplanètes dans les années 1990, les astronomes ont recensé plus de cinq mille mondes au-delà de notre système solaire. La question de l''existence d''une vie extraterrestre se pose avec plus d''acuité que jamais.',
 'La détection d''exoplanètes représente l''une des avancées les plus remarquables de l''astronomie contemporaine. Le télescope spatial Kepler, puis TESS, ont permis d''identifier des milliers de mondes orbitant autour d''étoiles lointaines.\n\nParmi ces découvertes, certaines planètes se situent dans la zone habitable de leur étoile, là où l''eau liquide pourrait exister en surface. Ces candidates suscitent un intérêt particulier pour la recherche de vie extraterrestre.\n\nLe télescope James Webb ouvre désormais de nouvelles perspectives en permettant l''analyse des atmosphères de ces planètes lointaines. Les prochaines années pourraient nous réserver des surprises considérables dans notre quête d''une autre Terre.',
 NULL, '2025-12-01 10:15:00', 1, 2, 3),

(4,
 'Inégalités numériques : le défi de l''inclusion',
 'L''accès inégal aux technologies numériques crée une nouvelle forme d''exclusion sociale. Des millions de personnes restent éloignées des bénéfices de la révolution numérique faute d''équipement, de connexion ou de compétences adéquates.',
 'La fracture numérique est une réalité qui touche des populations entières à travers le monde. Dans les pays développés eux-mêmes, des pans entiers de la population peinent à accéder aux services numériques essentiels.\n\nCette exclusion a des conséquences concrètes sur l''emploi, l''éducation et l''accès aux services publics. Les démarches administratives dématérialisées, la télémédecine ou encore la formation en ligne supposent une maîtrise minimale du numérique.\n\nDes initiatives publiques et privées tentent de réduire ces inégalités à travers des programmes d''équipement, de formation et de médiation numérique. L''enjeu est celui de l''égalité des chances dans une société toujours plus connectée.',
 NULL, '2025-12-15 08:45:00', 1, 3, 4),

(5,
 'La fermentation : une tradition qui revient en force',
 'Longtemps reléguée au rang de vieille technique de conservation, la fermentation connaît aujourd''hui un renouveau spectaculaire. Kombucha, kéfir, kimchi et choucroute envahissent les tables et captivent une nouvelle génération de cuisiniers.',
 'La fermentation est l''une des plus anciennes techniques de transformation alimentaire connues de l''humanité. Bien avant la réfrigération, nos ancêtres utilisaient ce procédé naturel pour conserver leurs aliments et développer des saveurs complexes.\n\nLes bienfaits pour la santé des aliments fermentés font l''objet d''un intérêt croissant de la part de la communauté scientifique. Les probiotiques qu''ils contiennent joueraient un rôle positif sur le microbiote intestinal et le système immunitaire.\n\nAujourd''hui, une communauté enthousiaste de fermenteurs amateurs partage ses recettes et expériences sur les réseaux sociaux. Cette pratique millénaire trouve ainsi une nouvelle jeunesse au croisement de la tradition culinaire et du bien-être contemporain.',
 NULL, '2026-01-05 11:00:00', 1, 2, 2),

(6,
 'Quantum computing : l''informatique de demain',
 'L''ordinateur quantique promet de révolutionner des domaines entiers allant de la cryptographie à la découverte de médicaments. Mais où en est réellement cette technologie et quand sera-t-elle accessible au grand public ?',
 'L''informatique quantique repose sur les principes de la mécanique quantique pour traiter l''information d''une manière radicalement différente des ordinateurs classiques. Là où un bit classique vaut 0 ou 1, un qubit peut exister dans une superposition des deux états simultanément.\n\nGrandes entreprises technologiques et laboratoires de recherche se livrent une course acharnée pour atteindre l''avantage quantique sur des problèmes réels. Les progrès sont réels mais les défis techniques restent considérables : maintenir la cohérence des qubits exige des conditions extrêmement contraignantes.\n\nLes applications potentielles sont néanmoins immenses : optimisation logistique, simulation moléculaire pour la pharmacologie, rupture des systèmes de chiffrement actuels. L''informatique quantique représente à la fois une promesse et un enjeu de sécurité majeur pour les années à venir.',
 NULL, '2026-01-18 16:20:00', 1, 3, 1),

(7,
 'Le retour du cinéma de quartier',
 'Face à la montée en puissance des plateformes de streaming, de nombreuses salles de cinéma indépendantes résistent et réinventent leur modèle. Programmation audacieuse, événements spéciaux et convivialité sont leurs armes pour fidéliser le public.',
 'La pandémie avait porté un coup sévère aux salles de cinéma, accélérant le basculement vers le streaming à domicile. Pourtant, les cinémas de proximité semblent avoir trouvé un second souffle en misant sur ce que les écrans domestiques ne peuvent offrir.\n\nL''expérience collective de la salle, l''obscurité complice, le grand écran et le son enveloppant restent des sensations irremplaçables pour de nombreux spectateurs. Les cinémas indépendants ont su cultiver cette spécificité en créant une programmation distinctive et des événements thématiques.\n\nCinéphiles-clubs, projections en plein air, débats avec les réalisateurs : ces initiatives créent du lien et transforment la sortie au cinéma en véritable moment de partage. Le cinéma de quartier s''affirme ainsi comme un lieu de culture et de vie sociale à part entière.',
 NULL, '2026-02-03 19:00:00', 0, 2, 2),

(8,
 'Microbiome et santé : comprendre notre flore intestinale',
 'Les recherches sur le microbiome intestinal bouleversent notre compréhension de la santé humaine. Cet écosystème de milliards de micro-organismes influence non seulement notre digestion, mais aussi notre humeur, nos défenses immunitaires et notre poids.',
 'Le microbiome humain est composé de plusieurs milliers de milliards de micro-organismes qui peuplent notre intestin. Cet écosystème complexe co-évolue avec nous depuis la naissance et joue un rôle essentiel dans notre santé globale.\n\nLes scientifiques ont établi des liens entre la composition du microbiome et de nombreuses pathologies : maladies inflammatoires, diabète, obésité, dépression et même certains cancers. Ces découvertes ouvrent des perspectives thérapeutiques prometteuses, notamment via les probiotiques et les prébiotiques.\n\nLa transplantation de microbiote fécal, encore expérimentale pour la plupart des indications, montre des résultats encourageants pour traiter certaines infections récidivantes. La médecine personnalisée du futur pourrait s''appuyer largement sur la modulation de notre flore intestinale.',
 NULL, '2026-02-20 10:30:00', 1, 3, 3),

(9,
 'Télétravail : bilan après cinq ans de pratique généralisée',
 'Cinq ans après la généralisation forcée du télétravail pendant la pandémie, les entreprises et les salariés dressent un bilan nuancé. Entre gains de productivité et risques d''isolement, le travail à distance a profondément reconfiguré le monde professionnel.',
 'La pandémie de 2020 a imposé en quelques semaines une transformation du travail que l''on anticipait pour la décennie suivante. Des millions de salariés ont dû adapter leur domicile en espace de travail, bouleversant les frontières entre vie professionnelle et vie personnelle.\n\nLes bilans menés depuis lors révèlent des réalités contrastées selon les individus et les métiers. Si beaucoup apprécient la flexibilité et le gain de temps sur les trajets, d''autres souffrent de l''isolement, de difficultés à déconnecter ou d''un manque de collaboration créative.\n\nLes entreprises naviguent désormais entre modèles hybrides et retours en présentiel imposés. La question du management à distance, de la cohésion d''équipe et de l''égalité entre télétravailleurs et non-télétravailleurs reste entière et continue d''alimenter les négociations sociales.',
 NULL, '2026-03-10 09:00:00', 1, 2, 4),

(10,
 'Biodiversité : les leçons des forêts tropicales',
 'Les forêts tropicales abritent plus de la moitié des espèces vivantes de notre planète. Leur destruction accélérée menace non seulement cette biodiversité irremplaçable, mais aussi les équilibres climatiques dont dépend toute vie sur Terre.',
 'Les forêts tropicales constituent les réservoirs de biodiversité les plus riches de notre planète. Amazonie, bassin du Congo, forêts d''Asie du Sud-Est : ces espaces abritent une richesse biologique sans équivalent, dont une large part reste encore inconnue de la science.\n\nLa déforestation, principalement due à l''agriculture intensive, à l''élevage et à l''exploitation minière, progresse à un rythme alarmant. Chaque année, des millions d''hectares disparaissent, emportant avec eux des espèces qui n''ont jamais été décrites et des savoirs ancestraux accumulés par les peuples autochtones.\n\nFace à cette urgence, des initiatives de conservation et de restauration se multiplient. Les approches qui associent les communautés locales à la protection de leur environnement se révèlent les plus efficaces et les plus durables. La préservation des forêts tropicales est désormais reconnue comme un enjeu de survie planétaire.',
 NULL, '2026-03-25 14:00:00', 1, 3, 3);
