# ActionBoard

ActionBoard is a collaborative task management web application that allows users to create, edit, and complete to-do items. Users can also share their task lists with others, enabling collaboration and real-time task tracking.

## Tech Stack

- **Frontend & Backend:** Ruby on Rails with Hotwire, Phlex, and Tailwind CSS (DaisyUI)
- **Database:** PostgreSQL
- **Authentication:** Devise
- **Authorization:** CanCanCan
- **Background Jobs:** Sidekiq (configured but not currently in use)
- **Caching & Session Storage:** Redis (configured for future use)

## Features

- Create and manage to-do lists
- Add, edit, and delete tasks
- Mark tasks as completed
- Filter tasks by status (all, pending, completed)
- Share task lists with other users
- Collaborate on shared lists

## Future Work & Improvements

### Features

- Real-time collaboration updates using ActionCable
- Comment system per task
- Task reminders and due dates
- Tagging and categorization
- Assign tasks to users
- Notifications system
- List/task activity history

### Improvements

- Improve development environment setup
- Create a test environment and add automated tests
- Customize Devise views for better UI/UX
- Add password recovery functionality
- Add pagination or infinite scrolling for long lists
- Display flash messages for actions and errors
- Notify users when a list is shared with them

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Ruby (3.2 or newer)
- Rails (7.x)
- PostgreSQL
- Redis
- Node.js & Yarn (for asset compilation)
- Docker (optional, for production build)

### Installation

Clone the repository:

```bash
git clone https://github.com/willgcr/actionboard.git
cd actionboard
```

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Ruby (3.2 or newer)
- Rails (7.x)
- PostgreSQL
- Redis
- Node.js & Yarn (for asset compilation)
- Docker (optional, for production build)

### Installation

Clone the repository:

```bash
git clone https://github.com/willgcr/actionboard.git
cd actionboard
```

Install dependencies:

```bash
bundle install
yarn install
```

Set up the database and seed it:

```bash
rails db:create
rails db:migrate
rails db:seed
```

Precompile assets:

```bash
rails assets:precompile
yarn build && yardn build:css
```

Run the server:

```bash
rails server
```

### Docker (Production Build Locally)

Set up the production `.env` file at `src/.env.production` with the necessary credentials:

```yaml
db:
  host: ...
  username: ...
  password: ...

redis:
  url: ...

secret_key_base: ...
```

Edit production credentials:

```bash
VISUAL="vim" rails credentials:edit -e production
```

To build the app:

```bash
docker compose --env-file ./src/.env.production up --build
```

To stop the app:

```bash
docker compose --env-file ./src/.env.production down --volumes
```

## Deployment

The app demo is currently deployed to a private virtual machine.

- **Domain:** [https://actionboard.willgcr.me](https://actionboard.willgcr.me)
- **Deployment:** Automated via GitHub Actions using SSH
- **Server:** NGINX as a reverse proxy
- **SSL:** Configured using Let's Encrypt for HTTPS

## License

This project is licensed under the GNU General Public License v3.0 (GPLv3). For more details, see the [official license](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Contact

For questions or suggestions, feel free to reach out:

- Email: [hello@willgcr.me](mailto:hello@willgcr.me)
- GitHub: [@willgcr](https://github.com/willgcr)
- LinkedIn: [linkedin.com/in/willgcr](https://linkedin.com/in/willgcr)