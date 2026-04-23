#!/bin/bash
set -euo pipefail

APP_DIR="${APP_DIR:-/app}"

mkdir -p "$APP_DIR/images"

if [ ! -f "$APP_DIR/images/trail-card.jpg" ]; then
  printf "placeholder image for the trail card fallback\n" > "$APP_DIR/images/trail-card.jpg"
fi

cat > "$APP_DIR/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Misty Ridge Loop Trail Card</title>
    <style>
      :root {
        --ink: #1d2a22;
        --muted: #66756d;
        --leaf: #2f6f4f;
        --leaf-dark: #184632;
        --gold: #f5b932;
        --mist: #eef5ee;
      }

      * {
        box-sizing: border-box;
      }

      body {
        min-height: 100vh;
        margin: 0;
        display: grid;
        place-items: center;
        background:
          radial-gradient(circle at 20% 10%, rgba(184, 213, 177, 0.8), transparent 28rem),
          linear-gradient(140deg, #f6f0e5 0%, #dceadd 52%, #b7cdbb 100%);
        color: var(--ink);
        font-family: "Trebuchet MS", "Avenir Next", sans-serif;
        padding: 32px;
      }

      .trail-card {
        width: min(92vw, 390px);
        display: block;
        overflow: hidden;
        border-radius: 28px;
        background: rgba(255, 255, 248, 0.96);
        color: inherit;
        text-decoration: none;
        box-shadow: 0 18px 40px rgba(46, 65, 48, 0.2);
        transition: transform 220ms ease, box-shadow 220ms ease;
      }

      .trail-card:hover,
      .trail-card:focus-visible {
        transform: translateY(-8px);
        box-shadow: 0 28px 58px rgba(37, 58, 42, 0.32);
      }

      .media {
        position: relative;
        height: 235px;
        overflow: hidden;
        background: var(--mist);
      }

      .media img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        transition: transform 450ms ease;
      }

      .trail-card:hover .media img,
      .trail-card:focus-visible .media img {
        transform: scale(1.07);
      }

      .badge {
        position: absolute;
        top: 16px;
        z-index: 1;
        border-radius: 999px;
        backdrop-filter: blur(10px);
        font-weight: 700;
      }

      .region {
        left: 16px;
        background: rgba(255, 255, 255, 0.78);
        padding: 8px 13px;
      }

      .rating {
        right: 16px;
        display: inline-flex;
        gap: 5px;
        align-items: center;
        background: rgba(29, 42, 34, 0.76);
        color: #fff8e6;
        padding: 8px 12px;
      }

      .rating .star {
        color: var(--gold);
      }

      .reason {
        position: absolute;
        inset-inline: 0;
        bottom: 0;
        padding: 44px 18px 16px;
        color: #fff;
        font-size: 0.92rem;
        font-weight: 700;
        background: linear-gradient(0deg, rgba(13, 28, 21, 0.82), rgba(13, 28, 21, 0));
      }

      .content {
        padding: 22px;
      }

      h1 {
        margin: 0 0 8px;
        font-size: 1.55rem;
        line-height: 1.1;
      }

      .location {
        margin: 0;
        max-width: 100%;
        color: var(--muted);
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      .stats {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
        margin: 20px 0;
      }

      .stat {
        min-width: 0;
        border-radius: 16px;
        background: #eef5ee;
        padding: 11px 8px;
        text-align: center;
        font-weight: 800;
      }

      .stat span {
        display: block;
        color: var(--muted);
        font-size: 0.74rem;
        font-weight: 700;
        margin-bottom: 2px;
      }

      .footer {
        border-top: 1px solid #d9e3d7;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;
        padding-top: 18px;
      }

      .difficulty-label,
      .terrain-label {
        color: var(--muted);
        display: block;
        font-size: 0.72rem;
        font-weight: 800;
        letter-spacing: 0.06em;
        text-transform: uppercase;
      }

      .meter {
        display: inline-grid;
        grid-template-columns: repeat(5, 18px);
        gap: 4px;
        margin-top: 7px;
      }

      .meter span {
        height: 7px;
        border-radius: 999px;
        background: #cddbcf;
      }

      .meter span:nth-child(-n + 3) {
        background: var(--leaf);
      }

      .terrain {
        margin: 4px 0 0;
        color: var(--leaf-dark);
        font-weight: 800;
        text-align: right;
      }
    </style>
  </head>
  <body>
    <main>
      <a class="trail-card" data-testid="trail-card" href="/trails/misty-ridge-loop" aria-label="Misty Ridge Loop trail details">
        <section class="media" aria-label="Trail photo">
          <img src="images/trail-card.jpg" alt="Misty Ridge Loop trail" />
          <span class="badge region" data-testid="region-badge">North Cascades</span>
          <span class="badge rating" data-testid="rating-badge"><span class="star">&#9733;</span> 4.7</span>
          <div class="reason" data-testid="reason-overlay">Best after early morning fog lifts</div>
        </section>
        <section class="content">
          <h1>Misty Ridge Loop</h1>
          <p class="location" data-testid="trail-location">Cascade Pass Trailhead, Marblemount, Washington</p>
          <div class="stats" aria-label="Trail stats">
            <div class="stat" aria-label="Trail distance"><span>Distance</span>12.4 km</div>
            <div class="stat" aria-label="Elevation gain"><span>Ascent</span>540 m</div>
            <div class="stat" aria-label="Estimated hiking time"><span>Time</span>3h 20m</div>
          </div>
          <footer class="footer">
            <div>
              <span class="difficulty-label">Difficulty: Moderate</span>
              <div class="meter" role="meter" aria-label="Difficulty" aria-valuemin="1" aria-valuemax="5" aria-valuenow="3" aria-valuetext="Moderate">
                <span></span><span></span><span></span><span></span><span></span>
              </div>
            </div>
            <div>
              <span class="terrain-label">Terrain</span>
              <p class="terrain">forest ridge</p>
            </div>
          </footer>
        </section>
      </a>
    </main>
  </body>
</html>
EOF
