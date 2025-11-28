# 🔥 Configuration Firebase - Déploiement automatique

Ce guide explique comment configurer le déploiement automatique sur Firebase à chaque push.

---

## 📋 Prérequis

- Un compte Google
- Git installé
- Un repo GitHub pour ce projet
- Node.js installé (pour Firebase CLI)

---

## 🚀 Étape 1 : Créer un projet Firebase

1. **Va sur** : https://console.firebase.google.com/

2. **Clique sur** "Ajouter un projet" ou "Add project"

3. **Nomme ton projet** : `tictactoe-betclic` (ou autre nom)

4. **Désactive Google Analytics** (optionnel, pas nécessaire pour ce projet)

5. **Clique sur** "Créer le projet"

6. **Note ton Project ID** (tu en auras besoin). Il ressemble à : `tictactoe-betclic-xxxxx`

---

## 🔧 Étape 2 : Initialiser Firebase Hosting

### Dans ton terminal :

```bash
cd /Users/theophilegregoire/development/tictactoe-betclic/clean_tic_tac_toe

# Installer Firebase CLI si pas déjà fait
npm install -g firebase-tools

# Se connecter à Firebase
firebase login

# Initialiser Firebase dans le projet
firebase init hosting
```

### Pendant l'initialisation, réponds :

1. **Use an existing project** → Choisis ton projet créé
2. **What do you want to use as your public directory?** → `build/web`
3. **Configure as a single-page app?** → `Yes`
4. **Set up automatic builds with GitHub?** → `No` (on va le faire manuellement)
5. **File build/web/index.html already exists. Overwrite?** → `No`

---

## 🔑 Étape 3 : Créer la clé de service Firebase

### 3.1 Générer la clé de service

```bash
# Créer un compte de service
firebase init hosting:github
```

OU manuellement :

1. **Va sur** : https://console.firebase.google.com/project/TON_PROJECT_ID/settings/serviceaccounts/adminsdk

2. **Clique sur** "Générer une nouvelle clé privée"

3. **Télécharge le fichier JSON**

4. **Copie TOUT le contenu du fichier JSON**

### 3.2 Ajouter le secret à GitHub

1. **Va sur ton repo GitHub** : https://github.com/TON_USERNAME/TON_REPO

2. **Settings** (du repo) → **Secrets and variables** → **Actions**

3. **New repository secret** 

4. **Name** : `FIREBASE_SERVICE_ACCOUNT`

5. **Value** : Colle TOUT le contenu JSON du fichier téléchargé

6. **Add secret**

### 3.3 Ajouter le Project ID

1. **New repository secret** 

2. **Name** : `FIREBASE_PROJECT_ID`

3. **Value** : Ton project ID (ex: `tictactoe-betclic-xxxxx`)

4. **Add secret**

---

## 📝 Étape 4 : Mettre à jour firebase.json

Assure-toi que ton `firebase.json` contient :

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

C'est déjà fait dans le projet ! ✅

---

## 🎯 Étape 5 : Push sur GitHub

### 5.1 Créer un repo GitHub (si pas déjà fait)

```bash
cd /Users/theophilegregoire/development/tictactoe-betclic/clean_tic_tac_toe

# Initialiser git si pas fait
git init

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit - Tic Tac Toe Flutter"

# Créer un repo sur GitHub puis :
git remote add origin https://github.com/TON_USERNAME/TON_REPO.git

# Push
git push -u origin main
```

### 5.2 Automatiquement déployé ! 🎉

À partir de maintenant, **chaque push sur `main`** déclenchera :

1. ✅ Installation de Flutter
2. ✅ Installation des dépendances (`flutter pub get`)
3. ✅ Lancement des tests (`flutter test`)
4. ✅ Build web (`flutter build web --release`)
5. ✅ Déploiement sur Firebase Hosting

---

## 🔍 Étape 6 : Vérifier le déploiement

### Sur GitHub :

1. **Va dans** l'onglet **Actions** de ton repo
2. **Tu verras** le workflow "Deploy to Firebase Hosting on merge"
3. **Clique dessus** pour voir les logs en temps réel

### URL de ton app :

Ton app sera disponible sur :
```
https://TON_PROJECT_ID.web.app
```

Ou
```
https://TON_PROJECT_ID.firebaseapp.com
```

---

## 🔄 Workflow de développement

### Pour déployer une mise à jour :

```bash
# 1. Faire tes modifications

# 2. Commit
git add .
git commit -m "Ajout de la fonctionnalité X"

# 3. Push (déploiement automatique !)
git push

# 4. Attendre ~2-3 minutes
# 5. Ton app est à jour sur Firebase !
```

### Preview des Pull Requests

Quand tu crées une Pull Request, GitHub Actions va :
- ✅ Build l'app
- ✅ Créer un **preview URL** temporaire
- ✅ Commenter la PR avec l'URL de preview

Exemple : `https://TON_PROJECT_ID--pr123-abc123.web.app`

---

## 🐛 Troubleshooting

### Erreur : "Failed to get Firebase project"

**Solution** : Vérifie que `FIREBASE_PROJECT_ID` est bien configuré dans les secrets GitHub.

### Erreur : "Permission denied"

**Solution** : Regénère la clé de service et mets à jour `FIREBASE_SERVICE_ACCOUNT`.

### Build échoue dans GitHub Actions

**Solution** : Vérifie les logs dans l'onglet Actions. Souvent c'est un test qui échoue.

```bash
# Tester localement avant de push
flutter test
flutter build web --release
```

### Les secrets ne sont pas reconnus

**Solution** : Les secrets doivent être EXACTEMENT :
- `FIREBASE_SERVICE_ACCOUNT` (tout le JSON)
- `FIREBASE_PROJECT_ID` (juste l'ID)
- `GITHUB_TOKEN` (automatique, pas besoin de le créer)

---

## 📊 Voir les statistiques

### Firebase Console

1. **Va sur** : https://console.firebase.google.com/
2. **Clique sur** ton projet
3. **Hosting** → Tu verras :
   - Nombre de visiteurs
   - Bande passante utilisée
   - Historique des déploiements

---

## 🎨 Domaine personnalisé (optionnel)

### Ajouter ton propre domaine :

1. **Firebase Console** → **Hosting** → **Add custom domain**
2. **Entre ton domaine** : `tictactoe.com`
3. **Suis les instructions** pour configurer les DNS
4. **Certificat SSL** : Automatique et gratuit !

---

## ✅ Checklist finale

- [ ] Projet Firebase créé
- [ ] Firebase CLI installé (`npm install -g firebase-tools`)
- [ ] `firebase login` effectué
- [ ] `firebase init hosting` configuré
- [ ] Clé de service ajoutée dans GitHub Secrets
- [ ] Project ID ajouté dans GitHub Secrets
- [ ] Workflows GitHub Actions créés (`.github/workflows/`)
- [ ] Code pushé sur GitHub
- [ ] Premier déploiement réussi

---

## 🎉 C'est terminé !

Maintenant, à chaque fois que tu push sur `main` :
```bash
git add .
git commit -m "Mon changement"
git push
```

**→ Ton app se met à jour automatiquement sur Firebase ! 🚀**

URL : `https://TON_PROJECT_ID.web.app`

