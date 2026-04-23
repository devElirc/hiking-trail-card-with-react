Build a Trail Card component that shows one hiking trail in a clean and modern card. The whole card should be clickable, so users can click anywhere to open the trail details page at /trails/{trail.id}.

At the top of the card, show a wide trail image. Use trail.imageUrl when it is available. If there is no image, use the default image at images/trail-card.jpg. When the user hovers over the card, the image should zoom in a little to give it a nice interactive feel.

On top of the image, add a small region label in the top-left corner using trail.region. It should have a rounded style and a soft white background so it stays easy to read. In the top-right corner, show the trail rating with a filled gold star and the rating number, such as 4.7.

If a reason message is provided, show it along the bottom of the image. When reasonStyle is set to "banner", show the message in a solid colored strip. When reasonStyle is set to "gradient", show it in a darker overlay that fades up from the bottom. Keep the reason text short and neat so it does not take too much space.

Below the image, add a padded content area. Show the trail name as the main title in bold, slightly larger text. Under that, show the location with a pin icon and muted text. If the location text is long, trim it cleanly instead of letting it wrap.

Then add a row with three quick trail details: distance, ascent, and time. Show each one with its own icon and value, such as 12.4 km, 540 m, and 3h 20m.

At the bottom of the card, add a divider line and one last row. On the left, show a difficulty meter with a visible label. On the right, show the terrain text, such as forest or coastal.

When the user hovers over the card, the whole card should lift slightly and the shadow should get stronger. The card should feel smooth, clear, and easy to click.

The component should use a trail object with values like id, name, imageUrl, region, rating, location, length, ascent, time, difficulty, and terrain. It can also accept an optional reason and reasonStyle.