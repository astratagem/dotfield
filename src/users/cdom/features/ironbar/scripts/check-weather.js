#!/usr/bin/env zx

const location = "Philadelphia, PA, USA";

// JavaScript uses Sunday as first day.
const weekday = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
];

// Bar

const data = await fetch(
  `https://wttr.in/${location}?format=%c %t|%m %t|%S|%s`,
).then((r) => r.text());

const [day, night, sunrise, sunset] = data.replaceAll("+", "").split("|");
const [sunriseH, sunriseM, sunriseS] = sunrise.split(":");
const [sunsetH, sunsetM, sunsetS] = sunset.split(":");

const currentTime = new Date();

const sunriseTime = new Date(currentTime);
sunriseTime.setHours(sunriseH);
sunriseTime.setMinutes(sunriseM);
sunriseTime.setSeconds(sunriseS);

const sunsetTime = new Date(currentTime);
sunsetTime.setHours(sunsetH);
sunsetTime.setMinutes(sunsetM);
sunsetTime.setSeconds(sunsetS);

let value = day;
if (currentTime < sunriseTime || currentTime > sunsetTime) {
  value = night;
}

await $`ironbar var set weather_current ${value}`;

// Popup

const forecast = await fetch(`https://wttr.in/${location}?format=j1`).then(
  (r) => r.json(),
);

for (const i in forecast.weather) {
  const report = forecast.weather[i];
  const day = weekday[new Date(report.date).getDay()];

  await $`ironbar var set weather_date_${i} ${day}`;
  await $`ironbar var set weather_avg_${i} '${report.avgtempC.padStart(2, "0")}'`;
  await $`ironbar var set weather_high_${i} '${report.maxtempC.padStart(2, "0")}'`;
  await $`ironbar var set weather_low_${i} '${report.mintempC.padStart(2, "0")}'`;
}
