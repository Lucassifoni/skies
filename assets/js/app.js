// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import "mdn-polyfills/NodeList.prototype.forEach"
import "mdn-polyfills/Element.prototype.closest"
import "mdn-polyfills/Element.prototype.matches"
import "url-search-params-polyfill"
import "formdata-polyfill"

// import { LiveSocket } from "phoenix_live_view"

(() => {
    const canvases = document.querySelectorAll('.sky-pic-luminancemap');
    console.log(canvases);
    canvases.forEach((canvas) => {
        const bitstring = canvas.getAttribute('data-bitmap');
        if (!bitstring) return;
        const values = bitstring.match(/[0-9A-F]{2}/g).map(i => parseInt(i, 16));
        if (values.length === 0 || values.length % 4 !== 0) return;
        const ctx = canvas.getContext("2d");
        const mul = values.length === 16 ? 2 : values.length === 64 ? 1 : -1;
        const n = values.length / (8 / mul);
        if (mul === -1) throw new Error("Luminance values length is incoherent.");
        values.forEach((v, index) => {
            let y = Math.floor(index / n);
            let x = index % n;
            ctx.fillStyle = `rgb(${v},${v},${v})`;
            ctx.fillRect(x * mul, y * mul, mul, mul);
        });
    });
})();