// Содержит ли URL текущий домен и get параметр action=buy
// Добавление в корзину
function checkLinkActionBuy(url) {
	var currentURL = new URL(url);
	var currentDomain = window.location.hostname;
	var actionParam = 'action=buy';
	
	// Проверяем, содержит ли URL текущий домен
	// При тестах отключайте
	if (currentURL.hostname === currentDomain) {
		
		// Проверяем, содержит ли URL параметр action=buy
		if (url.indexOf(actionParam) !== -1) {
			//console.log(url);
			return true;
		}
	}

	return false;
}


function addRefererAndCurrentUrl(event) {
	var expires = "";
	var days = 365;
	var date = new Date();
	date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000)); // в миллисекундах
	expires = "; expires=" + date.toUTCString();
	// Добавим 2 куки: текущая и предыдущая страница
	document.cookie = 'referer=' + document.referrer + expires + '; path=/';
	document.cookie = 'current_url=' + window.location.href + expires + '; path=/';
}

function observeDOMChangesAddBasket() {
	var observer = new MutationObserver(function(mutationsList) {
		for (var mutation of mutationsList) {
			for (var addedNode of mutation.addedNodes) {
				if (
					addedNode.nodeType === Node.ELEMENT_NODE &&
					((addedNode.tagName === 'A' && addedNode.href && checkLinkActionBuy(addedNode.href)) || 
					 addedNode.dataset.action === 'ADD_ALL_TO_CART' ||
					 addedNode.classList.contains('btn-feedback') ||
					 addedNode.classList.contains('add-to-marketplace-request-demo') ||
					 addedNode.classList.contains('btn-callback'))
				) {
					// обработчик события нажатия на ссылку или элемент формы
					addedNode.addEventListener('click', addRefererAndCurrentUrl);
				}
			}
		}
	});

	// Настраиваем наблюдатель за изменениями в DOM-дереве
	observer.observe(document.documentElement, { childList: true, subtree: true });
}

observeDOMChangesAddBasket();