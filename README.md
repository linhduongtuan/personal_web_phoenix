# Dr. Linh Duong - Personal Academic Website

🚀 **A modern, interactive personal academic website built with Phoenix LiveView featuring real-time Google Scholar integration and dynamic research analytics.**

[![Phoenix](https://img.shields.io/badge/Phoenix-1.8-orange.svg)](https://phoenixframework.org/)
[![Elixir](https://img.shields.io/badge/Elixir-1.14+-purple.svg)](https://elixir-lang.org/)
[![LiveView](https://img.shields.io/badge/LiveView-1.0-green.svg)](https://hexdocs.pm/phoenix_live_view/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-4.0-blue.svg)](https://tailwindcss.com/)

## 🌟 **Key Features**

### 🎯 **Interactive Research Dashboard**
- **📊 Real-time Google Scholar Integration** - Live citation counts, h-index, and i10-index tracking
- **📈 Dynamic Visualizations** - Interactive charts powered by Chart.js
- **🔄 Auto-refresh** - Updates every 5 minutes with manual refresh option
- **📱 Responsive Design** - Works seamlessly on all devices

### 🔬 **Academic Showcase**
- **📚 Publications Management** - Complete publication database with search and filtering
- **🎓 Research Areas** - AI in Medical Imaging, Computational Biology, Genetic Epidemiology
- **🌍 Global Collaborations** - International research network visualization
- **📝 Academic Blog** - Scientific insights and research updates

### 💻 **Technical Excellence**
- **⚡ Phoenix LiveView** - Real-time interactivity without JavaScript frameworks
- **🗄️ PostgreSQL + Ecto** - Robust data management
- **🎨 Modern UI/UX** - TailwindCSS with custom scientific styling
- **🔍 Advanced Search** - Global search across publications and blog posts
- **📊 Data Visualization** - Chart.js integration for research metrics

## 🖥️ **Live Demo**

**Dashboard Features:**
- Real-time citation tracking from Google Scholar profile
- Interactive publication timeline
- Research impact metrics with trend analysis
- Top-cited papers showcase
- Journal distribution visualization

**Research Profile:**
- 439+ citations and growing
- h-index: 12, i10-index: 8
- 38+ publications across top-tier journals
- International collaborations (Vietnam, Sweden, Italy, Germany, USA)

## 🚀 **Quick Start**

### **Prerequisites**

- Elixir 1.14+ and Erlang/OTP 25+
- Phoenix Framework 1.8+
- PostgreSQL 14+
- Node.js 18+ (for Chart.js and assets)

### **Installation**

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/personal_web_phoenix.git
   cd personal_web_phoenix
   ```

2. **Install dependencies:**
   ```bash
   mix setup
   ```

3. **Configure Google Scholar integration (optional):**
   ```bash
   export SCHOLAR_USER_ID="aZKRy1oAAAAJ"  # Replace with your Scholar ID
   export SERPAPI_KEY="your_api_key"       # Optional: for reliable API access
   ```

4. **Start the application:**
   ```bash
   mix phx.server
   ```

5. **Visit the website:**
   - Homepage: [`localhost:4000`](http://localhost:4000)
   - **🎯 Interactive Dashboard: [`localhost:4000/dashboard`](http://localhost:4000/dashboard)**
   - Publications: [`localhost:4000/publications`](http://localhost:4000/publications)

## 📊 **Google Scholar Integration**

### **Real-time Dashboard Features:**

- **📈 Live Metrics:** Citation counts, h-index, i10-index updates every 5 minutes
- **📊 Interactive Charts:** Publications by year, citations timeline, journal distribution  
- **🔄 Auto-refresh:** Seamless real-time updates without page reload
- **📱 Responsive:** Beautiful visualizations on desktop, tablet, and mobile

### **Setup Your Google Scholar Profile:**

1. Find your Google Scholar ID from your profile URL:
   ```
   https://scholar.google.com/citations?user=YOUR_ID_HERE&hl=en
   ```

2. Update the Scholar ID in `lib/personal_web_web/live/dashboard_live.ex`:
   ```elixir
   @scholar_user_id "YOUR_SCHOLAR_ID"
   ```

3. **Optional:** For production reliability, use SerpApi:
   - Sign up at [SerpApi.com](https://serpapi.com/)
   - Add your API key to environment variables
   - Enable SerpApi in the dashboard configuration

## 🗂️ **Project Architecture**

   ```bash
   mix ecto.create
   mix ecto.migrate
   ```

5. Seed sample data (optional):

   ```bash
   mix run priv/repo/seeds.exs
   ```

6. Start the Phoenix server:

   ```bash
   mix phx.server
   ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Project Structure

```text
lib/
├── personal_web/              # Business logic and contexts
│   ├── blog.ex               # Blog context with CRUD operations
│   ├── publications.ex       # Publications context
│   ├── blog/
│   │   └── post.ex           # Blog post schema
│   └── publications/
│       └── publication.ex    # Publication schema
└── personal_web_web/         # Web interface
    ├── controllers/          # Phoenix controllers
    ├── components/           # Reusable components and layouts
    └── router.ex            # URL routing

priv/repo/
├── migrations/              # Database migrations
└── seeds.exs               # Sample data seeding

assets/                     # Static assets (CSS, JS, images)
```

## Database Schemas

### Publications

- Title, authors, journal, year, DOI, abstract
- External links to papers
- Support for various publication types

### Blog Posts

- Title, content, publication date
- Draft/published status
- Markdown content support

## Customization

### Adding Content

1. **Publications**: Add new publications through the database or create an admin interface
2. **Blog Posts**: Create new blog posts with markdown content
3. **Research Projects**: Update the research page template with your projects
4. **Personal Info**: Modify the about page and homepage hero section

### Styling

- TailwindCSS classes are used throughout
- Custom styles can be added in `assets/css/app.css`
- Component styles are in the respective `.html.heex` templates

### Database

- Migrations are in `priv/repo/migrations/`
- Seed data can be customized in `priv/repo/seeds.exs`
- Schema definitions are in `lib/personal_web/*/`

## Development

### Running in Development

## 🚀 **Development Guide**

### **Running the Application**

```bash
# Start development server
mix phx.server

# Start with interactive shell  
iex -S mix phx.server

# Run database migrations
mix ecto.migrate

# Reset database (development only)
mix ecto.reset

# Run tests
mix test
```

### **Key Development Commands**

```bash
# Install new dependencies
mix deps.get

# Build assets
mix assets.build

# Format code
mix format

# Check code quality
mix credo
```

## 🌐 **Deployment**

### **Production Configuration**

Set these environment variables for production:

```bash
DATABASE_URL=postgresql://user:pass@localhost/personal_web_prod
SECRET_KEY_BASE=your-secret-key-base
PHX_HOST=yourdomain.com
SCHOLAR_USER_ID=your-google-scholar-id
SERPAPI_KEY=your-serpapi-key  # Optional
```

### **Deploy to Fly.io (Recommended)**

```bash
# Install Fly CLI
curl -L https://fly.io/install.sh | sh

# Login and launch
fly auth login
fly launch
fly deploy
```

### **Deploy to Heroku**

```bash
# Create Heroku app
heroku create your-app-name

# Add PostgreSQL
heroku addons:create heroku-postgresql:mini

# Set environment variables
heroku config:set SECRET_KEY_BASE=$(mix phx.gen.secret)
heroku config:set SCHOLAR_USER_ID=your-scholar-id

# Deploy
git push heroku main
heroku run "POOL_SIZE=2 mix ecto.migrate"
```

## 🔧 **Customization Guide**

### **Adding Your Research Data**

1. **Update Google Scholar ID:**
   ```elixir
   # In lib/personal_web_web/live/dashboard_live.ex
   @scholar_user_id "YOUR_SCHOLAR_ID"
   ```

2. **Add Your Publications:**
   ```bash
   # Use seeds file or create admin interface
   mix run priv/repo/seeds.exs
   ```

3. **Customize Research Areas:**
   ```elixir
   # In lib/personal_web/google_scholar.ex
   research_areas: ["Your", "Research", "Areas"]
   ```

### **Styling Customization**

```css
/* Add custom styles in assets/css/app.css */
.research-card {
  @apply bg-gradient-to-br from-blue-50 to-indigo-100;
}
```

### **Adding New Features**

1. **Create new LiveView pages:**
   ```bash
   mix phx.gen.live Context Schema schemas field:type
   ```

2. **Add new API integrations:**
   ```elixir
   # Create new context in lib/personal_web/
   defmodule PersonalWeb.NewIntegration do
     # Your integration logic
   end
   ```

## 📚 **Resources & Documentation**

### **Framework Documentation**
- [Phoenix Framework](https://phoenixframework.org/) - Web framework
- [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/) - Real-time features  
- [Ecto](https://hexdocs.pm/ecto/) - Database wrapper
- [TailwindCSS](https://tailwindcss.com/) - CSS framework

### **Academic Web Resources**
- [Google Scholar](https://scholar.google.com/) - Academic search engine
- [SerpApi Scholar](https://serpapi.com/google-scholar-api) - Reliable Scholar API
- [Academic Pages](https://academicpages.github.io/) - Academic website templates

### **Development Tools**
- [Chart.js](https://www.chartjs.org/) - Data visualization
- [Heroicons](https://heroicons.com/) - SVG icon library
- [Elixir](https://elixir-lang.org/) - Programming language

## 🤝 **Contributing**

This is a personal academic website, but you're welcome to:

1. **Fork for your own use** - Customize for your academic profile
2. **Report issues** - Help improve the codebase  
3. **Suggest features** - Academic-focused enhancements
4. **Share improvements** - Better visualizations or integrations

## 📄 **License**

MIT License - feel free to use this for your own academic website!

## 👨‍💻 **About the Developer**

**Dr. Linh Duong** - AI Researcher & Data Scientist
- 🎓 Specializing in AI in Medical Imaging, Computational Biology
- 📊 439+ citations, h-index: 12, international collaborations
- 🌐 Building tools at the intersection of AI and healthcare

---

⭐ **Star this repo if it helps with your academic presence!**

📧 **Questions?** Feel free to reach out or open an issue.

🚀 **Built with Phoenix LiveView** - Real-time web applications made simple.
