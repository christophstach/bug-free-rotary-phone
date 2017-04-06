DROP TABLE IF EXISTS StorchenNest;
DROP TABLE IF EXISTS Sichtung;
DROP TABLE IF EXISTS Nest;
DROP TABLE IF EXISTS StorchFamilie;
DROP TABLE IF EXISTS Storch;
DROP TABLE IF EXISTS StorchenArt;
DROP TABLE IF EXISTS StorchenGattung;


CREATE TABLE StorchenGattung (
  nameL VARCHAR(255) PRIMARY KEY,
  nameD VARCHAR(255)
);

CREATE TABLE StorchenArt (
  nameL                VARCHAR(255) PRIMARY KEY,
  nameD                VARCHAR(255),
  storchenGattungNameL VARCHAR(255) REFERENCES StorchenGattung
);

CREATE TABLE Storch (
  id               SERIAL PRIMARY KEY,
  geschlecht       CHAR(1) CHECK (geschlecht IN ('m', 'w')),
  storchenArtNameL VARCHAR(255) REFERENCES StorchenArt ON DELETE SET NULL
);

CREATE TABLE StorchFamilie (
  elternStorchId INTEGER,
  kindStorchId   INTEGER,
  PRIMARY KEY (kindStorchId, elternStorchId)
);

CREATE TABLE Nest (
  id  SERIAL PRIMARY KEY,
  plz INTEGER
);

CREATE TABLE Sichtung (
  storchId INTEGER REFERENCES Storch ON DELETE CASCADE,
  nestId   INTEGER REFERENCES Nest,
  datum    DATE,
  PRIMARY KEY (storchId, nestId, datum)
);


INSERT INTO Nest (plz) VALUES ('12459');
INSERT INTO StorchenGattung (nameL, nameD) VALUES ('S', 'Tolle Storchengattung');
INSERT INTO StorchenArt (nameL, nameD, storchenGattungNameL) VALUES ('D', 'Tolle Storchenart', 'S');
INSERT INTO Storch (geschlecht, storchenArtNameL) VALUES ('m', 'D');
INSERT INTO Storch (geschlecht, storchenArtNameL) VALUES ('w', 'D');
INSERT INTO Storch (geschlecht, storchenArtNameL) VALUES ('m', 'D');
INSERT INTO Sichtung (storchId, nestId, datum) VALUES (1, 1, now());
INSERT INTO StorchFamilie (elternStorchId, kindStorchId) VALUES (1, 3);
INSERT INTO StorchFamilie (elternStorchId, kindStorchId) VALUES (2, 3);