import { expect, test } from "@playwright/test";

/**
 * Verify the card exposes the requested trail fields and makes the entire card a link.
 */
test("renders the Misty Ridge Loop trail card content and link target", async ({ page }) => {
  await page.goto("/");

  const card = page.getByRole("link", { name: /misty ridge loop/i });
  await expect(card).toBeVisible();
  await expect(card).toHaveAttribute("href", "/trails/misty-ridge-loop");

  await expect(card.getByRole("heading", { name: "Misty Ridge Loop" })).toBeVisible();
  await expect(card.getByText("North Cascades")).toBeVisible();
  await expect(card.getByText("4.7")).toBeVisible();
  await expect(card.getByText("Cascade Pass Trailhead, Marblemount, Washington")).toBeVisible();
  await expect(card.getByText("12.4 km")).toBeVisible();
  await expect(card.getByText("540 m")).toBeVisible();
  await expect(card.getByText("3h 20m")).toBeVisible();
  await expect(card.getByText("Moderate")).toBeVisible();
  await expect(card.getByText("forest ridge")).toBeVisible();
  await expect(card.getByText("Best after early morning fog lifts")).toBeVisible();
});

/**
 * Verify the image, region/rating overlays, reason overlay, and stat labels are present.
 */
test("uses the trail image with readable overlays and accessible labels", async ({ page }) => {
  await page.goto("/");

  const card = page.getByRole("link", { name: /misty ridge loop/i });
  const image = card.getByRole("img", { name: /misty ridge loop trail/i });
  await expect(image).toHaveAttribute("src", /images\/trail-card\.jpg$/);

  await expect(card.getByText("North Cascades")).toHaveCSS("position", "absolute");
  await expect(card.getByText(/\u2605\s*4\.7/)).toBeVisible();
  await expect(card.getByText("Best after early morning fog lifts")).toHaveCSS("position", "absolute");
  await expect(card.getByLabel("Trail distance")).toContainText("12.4 km");
  await expect(card.getByLabel("Elevation gain")).toContainText("540 m");
  await expect(card.getByLabel("Estimated hiking time")).toContainText("3h 20m");
});

/**
 * Verify long location text is clipped cleanly and the difficulty meter is visible.
 */
test("keeps the location on one line and exposes a difficulty meter", async ({ page }) => {
  await page.goto("/");

  const location = page.getByText("Cascade Pass Trailhead, Marblemount, Washington");
  await expect(location).toHaveCSS("white-space", "nowrap");
  await expect(location).toHaveCSS("overflow", "hidden");
  await expect(location).toHaveCSS("text-overflow", "ellipsis");

  const meter = page.getByRole("meter", { name: /difficulty/i });
  await expect(meter).toBeVisible();
  await expect(meter).toHaveAttribute("aria-valuetext", "Moderate");
});

/**
 * Verify the card and image have hover transitions rather than a static layout.
 */
test("adds hover lift and image zoom interactions", async ({ page }) => {
  await page.goto("/");

  const card = page.getByRole("link", { name: /misty ridge loop/i });
  const image = page.getByRole("img", { name: /misty ridge loop trail/i });

  await expect(card).toHaveCSS("transition-property", /box-shadow|transform|all/);
  await expect(image).toHaveCSS("transition-property", /transform|all/);

  const beforeShadow = await card.evaluate((element) => getComputedStyle(element).boxShadow);
  await card.hover();
  await expect(card).not.toHaveCSS("box-shadow", beforeShadow);
});
