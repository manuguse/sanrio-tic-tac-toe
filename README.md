# Sanrio Tic Tac Toe

Um jogo da velha temático com personagens Sanrio desenvolvido em Flutter! 

## Características

- Jogo da velha clássico para dois jogadores
- Tema Sanrio com personagens queridos
- Personalização de nomes e avatares dos jogadores
- Interface intuitiva

## Como Executar

### Pré-requisitos

- Flutter SDK 3.5.0 ou superior
- Dart SDK 3.5.3 ou superior

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/sanrio-tic-tac-toe.git
cd sanrio-tic-tac-toe
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## Estrutura do Projeto

```
lib/
├── components/      # Componentes reutilizáveis
├── controller/      # Controladores da aplicação
├── model/           # Modelos de dados
│   ├── player_settings_model.dart
│   └── tic_tac_toe_model.dart
├── utils/           # Utilitários e helpers
├── view/            # Telas da aplicação
│   ├── player_settings_view.dart
│   └── tic_tac_toe_view.dart
└── main.dart        # Ponto de entrada

assets/
├── fonts/           # Fontes customizadas (Poppins, Schoolbell)
└── images/          # Imagens dos personagens Sanrio
```
## 🛠Desenvolvimento

Este projeto utiliza uma arquitetura baseada em Model-View-Controller (MVC) para organização do código:

- **Model**: Gerencia a lógica do jogo e dados dos jogadores
- **View**: Interface visual e componentes UI
- **Controller**: Conecta os modelos às views
