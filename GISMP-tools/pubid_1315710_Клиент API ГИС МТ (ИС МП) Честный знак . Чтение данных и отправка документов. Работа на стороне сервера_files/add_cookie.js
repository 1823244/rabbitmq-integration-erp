// �������� �� URL ������� ����� � get �������� action=buy
// ���������� � �������
function checkLinkActionBuy(url) {
	var currentURL = new URL(url);
	var currentDomain = window.location.hostname;
	var actionParam = 'action=buy';
	
	// ���������, �������� �� URL ������� �����
	// ��� ������ ����������
	if (currentURL.hostname === currentDomain) {
		
		// ���������, �������� �� URL �������� action=buy
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
	date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000)); // � �������������
	expires = "; expires=" + date.toUTCString();
	// ������� 2 ����: ������� � ���������� ��������
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
					// ���������� ������� ������� �� ������ ��� ������� �����
					addedNode.addEventListener('click', addRefererAndCurrentUrl);
				}
			}
		}
	});

	// ����������� ����������� �� ����������� � DOM-������
	observer.observe(document.documentElement, { childList: true, subtree: true });
}

observeDOMChangesAddBasket();