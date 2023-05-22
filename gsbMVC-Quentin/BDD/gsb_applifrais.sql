SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8*/
;
--
-- Base de données : `gsb_frais`
--

-- --------------------------------------------------------
--
-- Structure de la table `comptable`
--

CREATE TABLE `comptable` (
  `cid` char(4) NOT NULL,
  `cnom` char(30) DEFAULT NULL,
  `cprenom` char(30) DEFAULT NULL,
  `clogin` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cmdp` char(20) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `comptable`
--

INSERT INTO `comptable` (`cid`, `cnom`, `cprenom`, `clogin`, `cmdp`)
VALUES ('a001', 'DUPONT', 'Marcel', 'dmarcel', '4TH7zu'),
  ('a002', 'DELAGARE', 'Eude', 'deude', 'X4u7pT'),
  ('a003', 'DUBUS', 'Yves', 'dyves', 'KB7r4v');
-- --------------------------------------------------------
--
-- Structure de la table `etat`
--

CREATE TABLE `etat` (
  `id` char(2) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `etat`
--

INSERT INTO `etat` (`id`, `libelle`)
VALUES ('CL', 'Saisie clôturée'),
  ('CR', 'Fiche créée, saisie en cours'),
  ('RB', 'Remboursée'),
  ('VA', 'Validée et mise en paiement');
-- --------------------------------------------------------
--
-- Structure de la table `fichefrais`
--

CREATE TABLE `fichefrais` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `nbJustificatifs` int DEFAULT NULL,
  `montantValide` decimal(10, 2) DEFAULT NULL,
  `dateModif` date DEFAULT NULL,
  `idEtat` char(2) DEFAULT 'CR'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `fichefrais`
--

INSERT INTO `fichefrais` (
    `idVisiteur`,
    `mois`,
    `nbJustificatifs`,
    `montantValide`,
    `dateModif`,
    `idEtat`
  )
VALUES (
    'a17',
    '202303',
    1,
    '1332.50',
    '2023-05-09',
    'RB'
  ),
  (
    'a17',
    '202304',
    1,
    '1097.00',
    '2023-05-09',
    'RB'
  ),
  ('a17', '202305', 0, '0.00', '2023-05-09', 'CR'),
  (
    'a55',
    '202303',
    0,
    '1920.00',
    '2023-05-09',
    'VA'
  ),
  (
    'a55',
    '202304',
    1,
    '1987.60',
    '2023-05-09',
    'RB'
  ),
  ('a55', '202305', 0, '0.00', '2023-05-09', 'CL'),
  (
    'b13',
    '202303',
    0,
    '1742.00',
    '2023-05-09',
    'RB'
  ),
  ('b13', '202304', 0, '0.00', '2023-04-28', 'CL'),
  ('b13', '202305', 0, '0.00', '2023-05-09', 'CR');
-- --------------------------------------------------------
--
-- Structure de la table `fraisforfait`
--

CREATE TABLE `fraisforfait` (
  `id` char(3) NOT NULL,
  `libelle` char(20) DEFAULT NULL,
  `montant` decimal(5, 2) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `fraisforfait`
--

INSERT INTO `fraisforfait` (`id`, `libelle`, `montant`)
VALUES ('ETP', 'Forfait Etape', '110.00'),
  ('KM', 'Frais Kilométrique', '0.62'),
  ('NUI', 'Nuitée Hôtel', '80.00'),
  ('REP', 'Repas Restaurant', '25.00');
-- --------------------------------------------------------
--
-- Structure de la table `lignefraisforfait`
--

CREATE TABLE `lignefraisforfait` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `idFraisForfait` char(3) NOT NULL,
  `quantite` int DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `lignefraisforfait`
--

INSERT INTO `lignefraisforfait` (
    `idVisiteur`,
    `mois`,
    `idFraisForfait`,
    `quantite`
  )
VALUES ('a17', '202305', 'ETP', 2),
  ('a17', '202305', 'KM', 100),
  ('a17', '202305', 'NUI', 1),
  ('a17', '202305', 'REP', 2),
  ('b13', '202305', 'ETP', 3),
  ('b13', '202305', 'KM', 200),
  ('b13', '202305', 'NUI', 2),
  ('b13', '202305', 'REP', 6),
  ('a17', '202303', 'ETP', 2),
  ('a17', '202303', 'KM', 1000),
  ('a17', '202303', 'NUI', 3),
  ('a17', '202303', 'REP', 10),
  ('a17', '202304', 'ETP', 1),
  ('a17', '202304', 'KM', 1100),
  ('a17', '202304', 'NUI', 2),
  ('a17', '202304', 'REP', 5),
  ('b13', '202303', 'ETP', 2),
  ('b13', '202303', 'KM', 560),
  ('b13', '202303', 'NUI', 10),
  ('b13', '202303', 'REP', 15),
  ('b13', '202304', 'ETP', 5),
  ('b13', '202304', 'KM', 1000),
  ('b13', '202304', 'NUI', 10),
  ('b13', '202304', 'REP', 10),
  ('a55', '202303', 'ETP', 2),
  ('a55', '202303', 'KM', 1250),
  ('a55', '202303', 'NUI', 10),
  ('a55', '202303', 'REP', 5),
  ('a55', '202304', 'ETP', 7),
  ('a55', '202304', 'KM', 980),
  ('a55', '202304', 'NUI', 3),
  ('a55', '202304', 'REP', 10),
  ('a55', '202305', 'ETP', 0),
  ('a55', '202305', 'KM', 0),
  ('a55', '202305', 'NUI', 0),
  ('a55', '202305', 'REP', 0);
-- --------------------------------------------------------
--
-- Structure de la table `lignefraishorsforfait`
--

CREATE TABLE `lignefraishorsforfait` (
  `id` int NOT NULL,
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `dateFrais` date DEFAULT NULL,
  `montant` decimal(10, 2) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `lignefraishorsforfait`
--

INSERT INTO `lignefraishorsforfait` (
    `id`,
    `idVisiteur`,
    `mois`,
    `libelle`,
    `dateFrais`,
    `montant`
  )
VALUES (
    2,
    'a17',
    '202305',
    'Muguet',
    '2023-05-01',
    '60.00'
  ),
  (
    3,
    'b13',
    '202305',
    'Revues m&eacute;dicales',
    '2023-05-02',
    '120.00'
  ),
  (
    4,
    'a55',
    '202304',
    'Location salle',
    '2023-04-12',
    '120.00'
  ),
  (
    5,
    'a55',
    '202305',
    'Buffet',
    '2023-04-12',
    '100.00'
  ),
  (
    6,
    'a17',
    '202304',
    'Tickets bus',
    '2023-04-11',
    '20.00'
  ),
  (
    7,
    'a17',
    '202303',
    'Vélo électrique',
    '2023-03-15',
    '2.50'
  );
-- --------------------------------------------------------
--
-- Structure de la table `visiteur`
--

CREATE TABLE `visiteur` (
  `id` char(4) NOT NULL,
  `nom` char(30) DEFAULT NULL,
  `prenom` char(30) DEFAULT NULL,
  `login` char(20) DEFAULT NULL,
  `mdp` char(20) DEFAULT NULL,
  `adresse` char(30) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` char(30) DEFAULT NULL,
  `dateEmbauche` date DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Déchargement des données de la table `visiteur`
--

INSERT INTO `visiteur` (
    `id`,
    `nom`,
    `prenom`,
    `login`,
    `mdp`,
    `adresse`,
    `cp`,
    `ville`,
    `dateEmbauche`
  )
VALUES (
    'a131',
    'Villechalane',
    'Louis',
    'lvillechalane',
    'jux7g',
    '8 rue des Charmes',
    '46000',
    'Cahors',
    '2005-12-21'
  ),
  (
    'a17',
    'Andre',
    'David',
    'dandre',
    'oppg5',
    '1 rue Petit',
    '46200',
    'Lalbenque',
    '1998-11-23'
  ),
  (
    'a55',
    'Bedos',
    'Christian',
    'cbedos',
    'gmhxd',
    '1 rue Peranud',
    '46250',
    'Montcuq',
    '1995-01-12'
  ),
  (
    'a93',
    'Tusseau',
    'Louis',
    'ltusseau',
    'ktp3s',
    '22 rue des Ternes',
    '46123',
    'Gramat',
    '2000-05-01'
  ),
  (
    'b13',
    'Bentot',
    'Pascal',
    'pbentot',
    'doyw1',
    '11 allée des Cerises',
    '46512',
    'Bessines',
    '1992-07-09'
  ),
  (
    'b16',
    'Bioret',
    'Luc',
    'lbioret',
    'hrjfs',
    '1 Avenue gambetta',
    '46000',
    'Cahors',
    '1998-05-11'
  ),
  (
    'b19',
    'Bunisset',
    'Francis',
    'fbunisset',
    '4vbnd',
    '10 rue des Perles',
    '93100',
    'Montreuil',
    '1987-10-21'
  ),
  (
    'b25',
    'Bunisset',
    'Denise',
    'dbunisset',
    's1y1r',
    '23 rue Manin',
    '75019',
    'paris',
    '2010-12-05'
  ),
  (
    'b28',
    'Cacheux',
    'Bernard',
    'bcacheux',
    'uf7r3',
    '114 rue Blanche',
    '75017',
    'Paris',
    '2009-11-12'
  ),
  (
    'b34',
    'Cadic',
    'Eric',
    'ecadic',
    '6u8dc',
    '123 avenue de la République',
    '75011',
    'Paris',
    '2008-09-23'
  ),
  (
    'b4',
    'Charoze',
    'Catherine',
    'ccharoze',
    'u817o',
    '100 rue Petit',
    '75019',
    'Paris',
    '2005-11-12'
  ),
  (
    'b50',
    'Clepkens',
    'Christophe',
    'cclepkens',
    'bw1us',
    '12 allée des Anges',
    '93230',
    'Romainville',
    '2003-08-11'
  ),
  (
    'b59',
    'Cottin',
    'Vincenne',
    'vcottin',
    '2hoh9',
    '36 rue Des Roches',
    '93100',
    'Monteuil',
    '2001-11-18'
  ),
  (
    'c14',
    'Daburon',
    'François',
    'fdaburon',
    '7oqpv',
    '13 rue de Chanzy',
    '94000',
    'Créteil',
    '2002-02-11'
  ),
  (
    'c3',
    'De',
    'Philippe',
    'pde',
    'gk9kx',
    '13 rue Barthes',
    '94000',
    'Créteil',
    '2010-12-14'
  ),
  (
    'c54',
    'Debelle',
    'Michel',
    'mdebelle',
    'od5rt',
    '181 avenue Barbusse',
    '93210',
    'Rosny',
    '2006-11-23'
  ),
  (
    'd13',
    'Debelle',
    'Jeanne',
    'jdebelle',
    'nvwqq',
    '134 allée des Joncs',
    '44000',
    'Nantes',
    '2000-05-11'
  ),
  (
    'd51',
    'Debroise',
    'Michel',
    'mdebroise',
    'sghkb',
    '2 Bld Jourdain',
    '44000',
    'Nantes',
    '2001-04-17'
  ),
  (
    'e22',
    'Desmarquest',
    'Nathalie',
    'ndesmarquest',
    'f1fob',
    '14 Place d Arc',
    '45000',
    'Orléans',
    '2005-11-12'
  ),
  (
    'e24',
    'Desnost',
    'Pierre',
    'pdesnost',
    '4k2o5',
    '16 avenue des Cèdres',
    '23200',
    'Guéret',
    '2001-02-05'
  ),
  (
    'e39',
    'Dudouit',
    'Frédéric',
    'fdudouit',
    '44im8',
    '18 rue de l église',
    '23120',
    'GrandBourg',
    '2000-08-01'
  ),
  (
    'e49',
    'Duncombe',
    'Claude',
    'cduncombe',
    'qf77j',
    '19 rue de la tour',
    '23100',
    'La souteraine',
    '1987-10-10'
  ),
  (
    'e5',
    'Enault-Pascreau',
    'Céline',
    'cenault',
    'y2qdu',
    '25 place de la gare',
    '23200',
    'Gueret',
    '1995-09-01'
  ),
  (
    'e52',
    'Eynde',
    'Valérie',
    'veynde',
    'i7sn3',
    '3 Grand Place',
    '13015',
    'Marseille',
    '1999-11-01'
  ),
  (
    'f21',
    'Finck',
    'Jacques',
    'jfinck',
    'mpb3t',
    '10 avenue du Prado',
    '13002',
    'Marseille',
    '2001-11-10'
  ),
  (
    'f39',
    'Frémont',
    'Fernande',
    'ffremont',
    'xs5tq',
    '4 route de la mer',
    '13012',
    'Allauh',
    '1998-10-01'
  ),
  (
    'f4',
    'Gest',
    'Alain',
    'agest',
    'dywvt',
    '30 avenue de la mer',
    '13025',
    'Berre',
    '1985-11-01'
  );
--
-- Index pour les tables déchargées
--

--
-- Index pour la table `comptable`
--
ALTER TABLE `comptable`
ADD PRIMARY KEY (`cid`);
--
-- Index pour la table `etat`
--
ALTER TABLE `etat`
ADD PRIMARY KEY (`id`);
--
-- Index pour la table `fichefrais`
--
ALTER TABLE `fichefrais`
ADD PRIMARY KEY (`idVisiteur`, `mois`),
  ADD KEY `idEtat` (`idEtat`);
--
-- Index pour la table `lignefraishorsforfait`
--
ALTER TABLE `lignefraishorsforfait`
ADD PRIMARY KEY (`id`);
--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `lignefraishorsforfait`
--
ALTER TABLE `lignefraishorsforfait`
MODIFY `id` int NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 10;
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;