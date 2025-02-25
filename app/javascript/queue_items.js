document.addEventListener("turbo:load", function () {
    const variationContainer = document.getElementById("variation-fields");
    const addVariationButton = document.getElementById("add-variation");

    if (addVariationButton) {
        addVariationButton.addEventListener("click", function () {
            const index = variationContainer.children.length;
            const variationHTML = `
            <div class="input-group mb-2 variation-group">
                <input type="text" name="queue_item[variations][${index}][key]" placeholder="Property" class="form-control" />
                <input type="text" name="queue_item[variations][${index}][value]" placeholder="Value" class="form-control" />
                <button type="button" class="btn btn-outline-danger remove-variation">−</button>
            </div>
            `;

            variationContainer.insertAdjacentHTML("beforeend", variationHTML);
        });

        variationContainer.addEventListener("click", function (event) {
            if (event.target.classList.contains("remove-variation")) {
            event.target.parentElement.remove();
            }
        });
    }
});