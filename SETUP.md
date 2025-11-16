
# vue2

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VS Code](https://code.visualstudio.com/) + [Vue (Official)](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur).

## Recommended Browser Setup

- Chromium-based browsers (Chrome, Edge, Brave, etc.):
  - [Vue.js devtools](https://chromewebstore.google.com/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd) 
  - [Turn on Custom Object Formatter in Chrome DevTools](http://bit.ly/object-formatters)
- Firefox:
  - [Vue.js devtools](https://addons.mozilla.org/en-US/firefox/addon/vue-js-devtools/)
  - [Turn on Custom Object Formatter in Firefox DevTools](https://fxdx.dev/firefox-devtools-custom-object-formatters/)

## Type Support for `.vue` Imports in TS

TypeScript cannot handle type information for `.vue` imports by default, so we replace the `tsc` CLI with `vue-tsc` for type checking. In editors, we need [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) to make the TypeScript language service aware of `.vue` types.

## Customize configuration

See [Vite Configuration Reference](https://vite.dev/config/).

## Project Setup

```sh
pnpm install
```

### Compile and Hot-Reload for Development

```sh
pnpm dev
```

### Type-Check, Compile and Minify for Production

```sh
pnpm build
```


# Summary


I want to create a landing page more like a lead generator. I have a company with over 500 customer and now I want to propose a service I'm not sur about the name yet this will be about devops and infrastructure service provider on the shoulders of giants like GCP and docker with two offer, the first one WDI for We do it : with this offer we manage everything about hosting, security and deployments. The second offer is WIU for We Integrate with You here is the idea it a extension of our customer engineering team to fully manage your infrastructure. And both of the offer come with training that will allow our customer to fly by his own when he will feel ready

You based our infrastructure on gcp because we are partner since over 8 years and by this we can get competitive price

The landing page should be simple and minimalist the first section with a short sentence like DevOps & Infrastructure  success as a service the seconds section expose our 2 offers the third section is about the technology here you will include the logo of gcp and docker and under the gitlab, github, jenkins, Ubuntu and debian, OpenVPN and bash icon. The fourth section is a about us section that will say we did have over 500 customer manage over 1000 server instance across Europe, America and Asia with office present in france, spain, canada, japan that provide a 24h/24h human service. The final section is lead part with a "let's chat" where there is a contact card

SHOULD SPEAK ABOUT COST REDUCTION !!!

From expensive paid software license to self-hosted solution
From managed 

Add a final section FAQ with questions : 

- Which cloud provider did we use ?
As you see we use Google Cloud Plateforme, we are partner since 8 years, did deploy many software with them and we are now able to have special offer that will get you a competitive price
- Where will be your data ?
For WDI offer you data will be in our gcp infra so we will propose Europe(Belgia), North America(US or CA) and Asia
- What stack are we supporting ?
You currently deploy java8 11 17 21, python3.11 3.14, nodejs14 22 24, php7.4 8.2 8.4, PostgreSQL13 17, MySQL 8.4, Mariadb10 12, Redis8, MinIO, Grafana10 12, Loki2.4 3.4, Elasticsearch8 9, VictoriaMetrics... If you didn't find what you looked for contact us your team will integrate it


FAQ : Here are some of the most common questions we get from new clients
- Which cloud provider do you use?
We primarily use Google Cloud Platform (GCP). We’ve been an official partner for over 8 years, have deployed numerous solutions on their infrastructure, and can now offer special pricing and optimized configurations to give you a competitive edge.

- Where will my data be hosted?
For the WDI offer, your data will be hosted on our GCP infrastructure.
You can choose from data centers located in:
Europe (Belgium), North America (US or Canada), Asia We always help you select the best region for performance, compliance, and cost.
For WIU you will have your dedicated GCP account so you will be able to choose from all the GCP available regions

- What technology stack do you support?
We currently support a wide range of stacks, including:
Java: 8, 11, 17, 21
Python: 3.11 – 3.14
Node.js: 14, 22, 24
PHP: 7.4, 8.2, 8.4
Databases: PostgreSQL (13–17), MySQL (8.4), MariaDB (10–12)
Caching & Storage: Redis (8), MinIO
Monitoring & Logging: Grafana (10–12), Loki (2.4–3.4), Elasticsearch (8–9), VictoriaMetrics

If you don’t see your preferred stack listed, contact us — our team can integrate it for you.



## Setup the development environnement

```bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
#  Shows all available Node versions
nvm list-remote
# Install latest LTS or a specific one "nvm install 24"
nvm install --lts
# Check local Installed Versions
nvm ls
# Use a specific version 
nvm use 24.11
# Verify which version is active
node -v
# Set version 24.11 as default for all new terminals
nvm alias default 24.11
# Shows all aliases
nvm alias
# Remove a version 
nvm uninstall 18
# Recommanded Setup : Install pnpm, warn: you will need to install it for each node version
npm install -g pnpm

# Create a vuejs project
pnpm create vue@latest vue2 # Vue Router, Pinia with typescript
cd <your-project-name>
pnpm install
pnpm run dev
pnpm run build

# Tailwind, DaisyUI, Headless UI, Iconify for Vue, Heroicons for Vue, VueTailwind
pnpm add -D tailwindcss @tailwindcss/postcss 
# edit tailwind.config.js, src/main.css and postcss.config.js
```

