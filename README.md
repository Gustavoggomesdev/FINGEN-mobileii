# FINGEN-mobileii

Aplicativo de gerenciamento de investimentos em Flutter com arquitetura MVVM-C.

## 🚀 Características

- 🔐 Login com autenticação
- 💵 Gerenciamento de saldo
- 📊 Dashboard de investimentos
- 🏦 CDB dos principais bancos
- ₿ Criptomoedas (Bitcoin, Ethereum, etc)
- 🔄 Atualização em tempo real via API
- ⚙️ Configurações de perfil
- 📱 Navegação por abas

## 🏗️ Arquitetura MVVM-C

```
View ──► ViewModel ──► Service ──► Model
  │          │
  │          └──► Coordinator (Navegação)
  │
  └──► Design System Components
```

## 📁 Estrutura

```
lib/
├── app/                    # Config e rotas
├── core/                   # Coordinator, Network, Storage
├── design_system/          # Componentes reutilizáveis
│   ├── buttons/
│   ├── cards/
│   ├── dialogs/
│   ├── inputs/
│   └── navigation/
├── models/                 # Entidades
├── services/               # Lógica de dados
└── scenes/                 # Telas (Login, Home, etc)
    └── [scene]/
        ├── factory.dart
        ├── service.dart
        ├── view.dart
        └── view_model.dart
```

## 🎨 Design System

Todos componentes com ViewModels próprios:
- Buttons (Primary, Secondary)
- Cards (Investment, Summary)
- Inputs (TextField, Amount)
- Dialogs (AddBalance, Confirm)
- TabBar Navigation

## 📦 Dependências

```yaml
provider: ^6.1.1              # State management
http: ^1.1.0                  # HTTP client
flutter_secure_storage: ^9.0.0 # Secure storage
intl: ^0.18.1                 # Formatação
```

## 🔌 API

- **CoinGecko** - Preços de criptomoedas
- Dados mockados para CDB

## 💻 Instalação

```bash
git clone https://github.com/seu-usuario/investment-manager.git
cd investment-manager
flutter pub get
flutter run
```

## 🎯 Padrões

- ✅ MVVM-C Architecture
- ✅ Component-based Design
- ✅ Factory Pattern
- ✅ Provider State Management
- ✅ Coordinator Navigation

## 📝 Licença

MIT License

---

