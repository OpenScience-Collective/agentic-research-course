# Presentations

Course slides are authored as JSON files and rendered by the [agentic-presentation-builder](https://github.com/neuromechanist/agentic-presentation-builder).

## Running the Slides

### 1. Clone the presentation engine

```bash
git clone https://github.com/neuromechanist/agentic-presentation-builder.git
cd agentic-presentation-builder
```

### 2. Install dependencies

```bash
bun install
# or: npm install
```

### 3. Copy or symlink the presentation file

Copy the JSON file you want to view into the `public/` directory of the presentation engine:

```bash
cp /path/to/agentic-research-course/presentations/week-01/presentation.json public/week-01.json
```

Or create a symlink (recommended, so edits stay in sync):

```bash
ln -s /path/to/agentic-research-course/presentations/week-01/presentation.json public/week-01.json
```

### 4. Start the dev server

```bash
bun run dev
# or: npm run dev
```

### 5. Open in your browser

Navigate to:

```
http://localhost:3000/?presentation=./public/week-01.json
```

## Keyboard Shortcuts

Once the presentation is open:

- **Arrow keys** or **Space**: navigate slides
- **Escape**: overview mode
- **S**: speaker notes window
- **F**: fullscreen

## Structure

Each week's folder contains:

- `outline.md`: text outline of the session (speaker reference)
- `presentation.json`: full slide deck in agentic-presentation-builder JSON format
