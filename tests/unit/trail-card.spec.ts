import { describe, expect, it } from "vitest";
import fs from "node:fs";

const appHtmlPath = `${process.env.APP_DIR || "/app"}/index.html`;
const quote = String.raw`["']`;

function readHtml() {
  if (!fs.existsSync(appHtmlPath)) {
    throw new Error(`Missing ${appHtmlPath}`);
  }

  return fs.readFileSync(appHtmlPath, "utf8");
}

describe("hiking trail card markup contract", () => {
  /**
   * Contract: the page should render the requested Misty Ridge Loop content and route target.
   */
  it("includes the requested trail data and detail route", () => {
    const html = readHtml();

    expect(html).toContain("Misty Ridge Loop");
    expect(html).toContain("misty-ridge-loop");
    expect(html).toContain("/trails/misty-ridge-loop");
    expect(html).toContain("North Cascades");
    expect(html).toContain("4.7");
    expect(html).toContain("Cascade Pass Trailhead, Marblemount, Washington");
    expect(html).toContain("12.4 km");
    expect(html).toContain("540 m");
    expect(html).toContain("3h 20m");
    expect(html).toContain("Moderate");
    expect(html).toMatch(/forest ridge/i);
    expect(html).toContain("Best after early morning fog lifts");
  });

  /**
   * Contract: the card should expose stable accessible text and labels for the UI verifier.
   */
  it("includes accessible image, stat, and difficulty labels", () => {
    const html = readHtml();

    expect(html).toMatch(new RegExp(`src=${quote}images/trail-card\\.jpg${quote}`, "i"));
    expect(html).toMatch(new RegExp(`alt=${quote}[^"']+${quote}`, "i"));
    expect(html).toMatch(/(Distance|Length)/i);
    expect(html).toMatch(/Ascent/i);
    expect(html).toMatch(/Time/i);
    expect(html).toMatch(/Difficulty/i);
    expect(html).toMatch(/Moderate/);
  });

  /**
   * Contract: the image source and truncation styling should support the requested card layout.
   */
  it("includes the requested image source and location truncation styling", () => {
    const html = readHtml();

    expect(html).toMatch(new RegExp(`src=${quote}images/trail-card\\.jpg${quote}`));
    expect(html).toMatch(/text-overflow\s*:\s*ellipsis/);
    expect(html).toMatch(/white-space\s*:\s*nowrap/);
  });

  /**
   * Contract: the reason overlay should use a gradient background, as required by the task.
   */
  it("applies a gradient background to the reason overlay", () => {
    const html = readHtml();

    expect(html).toMatch(/\.[A-Za-z0-9_-]*reason[A-Za-z0-9_-]*[^{]*\{[^}]*background[^:]*:[^;]*gradient/is);
  });

  /**
   * Contract: the interaction styling should include hover lift, stronger shadow, and image zoom.
   */
  it("includes hover lift and image zoom styling", () => {
    const html = readHtml();

    expect(html).toMatch(/transition\s*:[^;]*(transform|box-shadow)/);
    expect(html).toMatch(/:hover[\s\S]*translateY\(/);
    expect(html).toMatch(/:hover[\s\S]*box-shadow/);
    expect(html).toMatch(/:hover[\s\S]*scale\(/);
  });

});
