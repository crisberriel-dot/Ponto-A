# Ponto A — Guia de instalação

Siga nesta ordem. Leva uns 20-30 minutos na primeira vez, só uma vez.

---

## PARTE 1 — Criar o banco de dados (Supabase)

1. Acesse **supabase.com** e crie uma conta gratuita (dá pra usar login do GitHub ou Google).
2. Clique em **New project**. Dê um nome (ex: "ponto-a") e crie uma senha de banco — guarde essa senha em algum lugar seguro, mas você não vai precisar dela no dia a dia.
3. Espere o projeto terminar de criar (leva ~2 minutos).
4. No menu lateral, clique em **SQL Editor** → **New query**.
5. Abra o arquivo `supabase-schema.sql` (que veio junto com esse pacote), copie todo o conteúdo, cole no editor e clique em **Run**.
   - Isso cria as tabelas onde seus dados vão morar, já com a proteção de que só você acessa os seus dados.
6. Agora crie o seu usuário de login: menu lateral → **Authentication** → **Users** → **Add user** → **Create new user**.
   - Preencha e-mail e senha (essa é a senha que você vai usar pra entrar no app).
   - Marque a opção **Auto Confirm User** (ou similar) pra não precisar confirmar por e-mail.
7. Pegue suas chaves de conexão: menu lateral → **Project Settings** (ícone de engrenagem) → **API**.
   - Copie o valor de **Project URL**.
   - Copie o valor de **anon public** (a chave pública — essa é segura pra deixar visível no código, ela não dá acesso a nada sem login).

---

## PARTE 2 — Colar as chaves no app

1. Abra o arquivo `config.js` num editor de texto qualquer (Bloco de Notas, VS Code, ou até o editor de texto do próprio celular).
2. Substitua:
   ```js
   window.SUPABASE_URL = "COLE_AQUI_A_PROJECT_URL";
   window.SUPABASE_ANON_KEY = "COLE_AQUI_A_ANON_PUBLIC_KEY";
   ```
   pelos valores que você copiou no passo 7 da Parte 1.
3. Salve o arquivo.

---

## PARTE 3 — Publicar no GitHub Pages

1. Acesse **github.com** e crie uma conta gratuita, se ainda não tiver.
2. Clique em **New repository**. Nome sugerido: `ponto-a`. Marque como **Public**. Crie.
3. Dentro do repositório, clique em **uploading an existing file** (ou "Add file" → "Upload files").
4. Envie todos os arquivos deste pacote:
   - `index.html`
   - `config.js` (já com suas chaves coladas)
   - `manifest.json`
   - `sw.js`
   - `icon-192.png`
   - `icon-512.png`
5. Clique em **Commit changes** (o botão verde) pra salvar.
6. Vá em **Settings** (do repositório) → **Pages** (menu lateral).
7. Em **Source**, escolha **Deploy from a branch** → branch **main** → pasta **/ (root)** → **Save**.
8. Espere 1-2 minutos. A página vai te mostrar um link tipo:
   `https://seu-usuario.github.io/ponto-a/`
9. Abra esse link no celular.

---

## PARTE 4 — Instalar como app no celular

**iPhone (Safari):**
Abra o link → toque no ícone de compartilhar (quadrado com seta pra cima) → **Adicionar à Tela de Início**.

**Android (Chrome):**
Abra o link → toque nos três pontinhos no canto → **Adicionar à tela inicial** (ou vai aparecer um banner automático perguntando).

Pronto — vira um ícone de verdade, abre em tela cheia, sem barra de navegador.

---

## No dia a dia

- Entre com o e-mail e senha que você criou na Parte 1, passo 6.
- Pode entrar de qualquer aparelho (celular, computador) com a mesma conta — os dados são os mesmos em todo lugar.
- Se quiser mudar sua senha depois, isso é feito no painel do Supabase (Authentication → Users → clique no seu usuário → Reset password).

## Se algo der errado

- **Tela de login não aparece / dá erro:** confira se colou as chaves certas no `config.js` (Parte 2).
- **Login não funciona:** confira se marcou "Auto Confirm User" ao criar o usuário (Parte 1, passo 6).
- **Página em branco:** espere alguns minutos após publicar no GitHub Pages — às vezes demora pra propagar.
