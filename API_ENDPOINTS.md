# API Endpoints - Vue d'Ensemble

## 📊 Tableau Récapitulatif

| Endpoint | Méthode | Authentification | Utilisé par Frontend | Données Exposées | Sécurité |
|----------|---------|------------------|---------------------|------------------|----------|
| `POST /api/bookings/` | POST | ❌ Non | ✅ Oui | Uniquement la réservation créée | ✅ Sûr |
| `GET /api/bookings/available-slots` | GET | ❌ Non | ✅ Oui | Créneaux horaires (pas de données perso) | ✅ Sûr |
| `GET /api/bookings/future` | GET | 🔐 API Key | ❌ Non | **TOUTES les réservations** | 🔒 Protégé |
| `GET /api/bookings/{id}` | GET | 🔐 API Key | ❌ Non | Une réservation complète | 🔒 Protégé |
| `DELETE /api/bookings/{id}` | DELETE | 🔐 API Key | ❌ Non | Suppression d'une réservation | 🔒 Protégé |
| `GET /health` | GET | ❌ Non | ❌ Non | Statut du serveur | ✅ Sûr |
| `GET /` | GET | ❌ Non | ❌ Non | Info sur l'API | ✅ Sûr |

## ✅ Endpoints Publics (Sans Authentification)

### 1. Créer/Modifier une Réservation

**Endpoint :** `POST /api/bookings/`
**Utilisé par :** Frontend Vue 3
**Authentification :** ❌ Aucune

**Exemple de requête :**
```bash
curl -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "name": "John Doe",
    "booking_date": "2025-12-15",
    "booking_time": "14:30",
    "description": "Infrastructure audit"
  }'
```

**Réponse :**
```json
{
  "action": "created",
  "booking": {
    "id": "abc-123",
    "email": "user@example.com",
    "name": "John Doe",
    "booking_date": "2025-12-15",
    "booking_time": "14:30:00",
    "description": "Infrastructure audit",
    "created_at": "2025-11-14T10:00:00",
    "updated_at": "2025-11-14T10:00:00"
  },
  "message": "Your booking has been confirmed for 2025-12-15 at 14:30:00"
}
```

**Sécurité :** ✅ Sûr - Ne retourne que la réservation qui vient d'être créée, pas les autres.

---

### 2. Obtenir les Créneaux Disponibles

**Endpoint :** `GET /api/bookings/available-slots?booking_date=YYYY-MM-DD`
**Utilisé par :** Frontend Vue 3
**Authentification :** ❌ Aucune

**Exemple de requête :**
```bash
curl http://localhost:8000/api/bookings/available-slots?booking_date=2025-12-15
```

**Réponse :**
```json
{
  "date": "2025-12-15",
  "available_slots": ["09:00", "09:30", "10:00", "10:30", ...],
  "booked_slots": ["14:30"]
}
```

**Sécurité :** ✅ Sûr - Montre seulement les heures disponibles, aucune donnée personnelle.

---

## 🔒 Endpoints Protégés (Requiert API Key)

### 3. Liste de Toutes les Réservations Futures

**Endpoint :** `GET /api/bookings/future`
**Utilisé par :** Administration uniquement
**Authentification :** 🔐 **API Key requise** via header `X-API-Key`

**Exemple de requête :**
```bash
curl -H "X-API-Key: votre-cle-secrete" \
  http://localhost:8000/api/bookings/future
```

**Réponse :**
```json
[
  {
    "id": "abc-123",
    "email": "user1@example.com",
    "name": "John Doe",
    "booking_date": "2025-12-15",
    "booking_time": "14:30:00",
    "description": "Audit",
    "created_at": "2025-11-14T10:00:00",
    "updated_at": "2025-11-14T10:00:00"
  },
  {
    "id": "def-456",
    "email": "user2@example.com",
    "name": "Jane Smith",
    ...
  }
]
```

**⚠️ DANGER SI NON PROTÉGÉ :** Expose **toutes** les réservations avec emails et noms !

**✅ MAINTENANT PROTÉGÉ :** Requiert une clé API secrète.

---

### 4. Détails d'une Réservation Spécifique

**Endpoint :** `GET /api/bookings/{booking_id}`
**Utilisé par :** Administration uniquement
**Authentification :** 🔐 **API Key requise**

**Exemple de requête :**
```bash
curl -H "X-API-Key: votre-cle-secrete" \
  http://localhost:8000/api/bookings/abc-123
```

**Réponse :**
```json
{
  "id": "abc-123",
  "email": "user@example.com",
  "name": "John Doe",
  "booking_date": "2025-12-15",
  "booking_time": "14:30:00",
  "description": "Infrastructure audit",
  "created_at": "2025-11-14T10:00:00",
  "updated_at": "2025-11-14T10:00:00"
}
```

**✅ PROTÉGÉ :** Requiert la clé API.

---

### 5. Supprimer une Réservation

**Endpoint :** `DELETE /api/bookings/{booking_id}`
**Utilisé par :** Administration uniquement
**Authentification :** 🔐 **API Key requise**

**Exemple de requête :**
```bash
curl -X DELETE \
  -H "X-API-Key: votre-cle-secrete" \
  http://localhost:8000/api/bookings/abc-123
```

**Réponse :** HTTP 204 (No Content)

**⚠️ DANGER SI NON PROTÉGÉ :** N'importe qui pourrait supprimer les réservations !

**✅ MAINTENANT PROTÉGÉ :** Requiert la clé API.

---

## 🔑 Comment Utiliser les Endpoints Protégés

### 1. Générer une Clé API

```bash
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

**Exemple de sortie :** `c86oW8EVk_PZPbkPtvmkyrmQZrjh7Q8d1aKjI36MDIY`

### 2. Configurer dans `.env`

```env
ADMIN_API_KEY=c86oW8EVk_PZPbkPtvmkyrmQZrjh7Q8d1aKjI36MDIY
```

### 3. Utiliser avec curl

```bash
curl -H "X-API-Key: c86oW8EVk_PZPbkPtvmkyrmQZrjh7Q8d1aKjI36MDIY" \
  http://localhost:8000/api/bookings/future
```

### 4. Utiliser avec la Documentation Interactive

1. Ouvrir http://localhost:8000/docs
2. Cliquer sur **"Authorize"** (🔒 en haut à droite)
3. Entrer la clé API dans le champ **X-API-Key**
4. Cliquer sur **"Authorize"**
5. Maintenant tous les endpoints protégés sont accessibles !

---

## 📝 Résumé de Sécurité

### ✅ Ce qui est Sûr (Public)

- ✅ Créer une réservation → Ne retourne que la réservation créée
- ✅ Voir les créneaux disponibles → Aucune donnée personnelle

### 🔒 Ce qui est Protégé (Admin)

- 🔒 Voir toutes les réservations → Requiert API Key
- 🔒 Voir une réservation spécifique → Requiert API Key
- 🔒 Supprimer une réservation → Requiert API Key

### ❌ Sans API Key

```bash
curl http://localhost:8000/api/bookings/future
```

**Réponse :**
```json
{
  "detail": "API Key is missing"
}
```

### ✅ Avec API Key

```bash
curl -H "X-API-Key: votre-cle" http://localhost:8000/api/bookings/future
```

**Réponse :** Liste complète des réservations

---

## 🎯 Impact sur le Frontend

**Aucun impact !** Le frontend continue de fonctionner normalement :

- ✅ Les utilisateurs peuvent créer des réservations
- ✅ Les créneaux disponibles sont visibles
- ✅ Le système de réservation fonctionne parfaitement

**La clé API est uniquement pour l'administration backend.**

---

## 📚 Documentation Complète

- [SECURITY_SUMMARY.md](SECURITY_SUMMARY.md) - Résumé de sécurité
- [backend/SECURITY.md](backend/SECURITY.md) - Guide de sécurité détaillé
- [backend/README.md](backend/README.md) - Documentation de l'API
- [INTEGRATION.md](INTEGRATION.md) - Guide d'intégration

---

## ❓ Questions Fréquentes

**Q : Pourquoi certains endpoints sont publics ?**
R : Le frontend a besoin de créer des réservations et voir les créneaux disponibles. Ces opérations ne donnent pas accès aux données des autres utilisateurs.

**Q : Pourquoi protéger les autres endpoints ?**
R : Ils exposent des données sensibles (emails, noms de tous les utilisateurs) qui ne doivent être accessibles qu'aux administrateurs.

**Q : Mon frontend a-t-il besoin de la clé API ?**
R : Non ! Le frontend n'utilise que les endpoints publics.

**Q : Comment gérer plusieurs administrateurs ?**
R : Partagez la même clé API (stockée dans votre gestionnaire de mots de passe d'équipe).

**Q : Puis-je avoir plusieurs clés API différentes ?**
R : Pas avec l'implémentation actuelle, mais c'est possible à ajouter si nécessaire.

---

## 🎉 Conclusion

Votre API est maintenant correctement sécurisée :

- ✅ Endpoints publics pour le frontend
- 🔒 Endpoints protégés pour l'administration
- 📊 Pas de fuite de données personnelles
- 🔑 Authentification simple et efficace

**Le système est prêt pour la production !**
