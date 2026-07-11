// همه‌چیز داخل یک IIFE برای تمیز بودن فضای گلوبال
(function () {
  'use strict';

  const ITEMS_PER_PAGE = 6;
  const DISCOUNT_PROBABILITY = 0.02; // ۲٪ احتمال تخفیف

  let products = [];
  let currentPage = loadFromLocalStorage('lastPage', 1) || 1;
  let cart = loadFromLocalStorage('cartItems', []);

  // --- گرفتن المنت‌ها از DOM ---
  const productsContainer = document.getElementById('products-container');
  const btnPrev = document.getElementById('btn-prev');
  const btnNext = document.getElementById('btn-next');
  const pageInfo = document.getElementById('page-info');

  const cartList = document.getElementById('cart-list');
  const cartSummary = document.getElementById('cart-summary');

  const discountBanner = document.getElementById('discount-banner');

  const statAdd = document.getElementById('stat-add');
  const statDetails = document.getElementById('stat-details');
  const statPageClicks = document.getElementById('stat-pageClicks');

  // --- localStorage helpers ---

  // function declaration
  function loadFromLocalStorage(key, defaultValue) {
    try {
      const raw = localStorage.getItem(key);
      return raw ? JSON.parse(raw) : defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  // function expression
  const saveToLocalStorage = function (key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  };

  // --- cookie helpers (برای کلیک‌های صفحه‌بندی) ---

  // ذخیره در کوکی
  function setCookie(name, value, days = 7) {
    const d = new Date();
    d.setTime(d.getTime() + days * 24 * 60 * 60 * 1000);
    document.cookie = `${name}=${value};expires=${d.toUTCString()};path=/`;
  }

  // خواندن از کوکی
  function getCookie(name) {
    const decoded = decodeURIComponent(document.cookie || '');
    const parts = decoded.split(';');
    for (let p of parts) {
      p = p.trim();
      if (!p) continue;
      const [key, val] = p.split('=');
      if (key === name) return val;
    }
    return null;
  }

  // --- closure برای شمارنده کلیک‌ها ---
  // این‌بار طوری نوشتیم که هم می‌تونه با localStorage کار کنه هم با کوکی
  function createClickCounter(initialValue, persistFn, persistKey) {
    let count = initialValue || 0; // متغیر خصوصی داخل closure

    return {
      increment: function () {
        count++;
        if (persistFn && persistKey) {
          // ذخیره در localStorage یا کوکی (بسته به تابعی که دادی)
          persistFn(persistKey, count);
        }
        return count;
      },
      get: () => count // arrow function
    };
  }

  // ـــ این دوتا در localStorage ذخیره می‌شن ـــــ
  const addClicksCounter = createClickCounter(
    loadFromLocalStorage('clicks_addToCart', 0),
    saveToLocalStorage,
    'clicks_addToCart'
  );

  const detailsClicksCounter = createClickCounter(
    loadFromLocalStorage('clicks_viewDetails', 0),
    saveToLocalStorage,
    'clicks_viewDetails'
  );

  // ـــ این یکی در کوکی ذخیره می‌شه (pageNavClicks) ـــــ
  const pageClicksCounter = createClickCounter(
    Number(getCookie('pageNavClicks') || '0'),
    setCookie,
    'pageNavClicks'
  );

  // --- توابع مربوط به محصولات و صفحه‌بندی ---

  // function expression برای گرفتن محصولات یک صفحه
  const getPageProducts = function (page) {
    const start = (page - 1) * ITEMS_PER_PAGE;
    return products.slice(start, start + ITEMS_PER_PAGE);
  };

  // function declaration برای رندر محصولات
  function renderProducts(page) {
    if (!products.length) return;

    const totalPages = Math.ceil(products.length / ITEMS_PER_PAGE);
    if (page < 1) page = 1;
    if (page > totalPages) page = totalPages;

    currentPage = page;
    saveToLocalStorage('lastPage', currentPage);

    productsContainer.innerHTML = '';

    const pageProducts = getPageProducts(currentPage);

    pageProducts.forEach((product) => {
      const card = document.createElement('div');
      card.className = 'product-card';
      card.innerHTML = `
        <img src="${product.image}" alt="${product.title}">
        <div class="product-title">${product.title}</div>
        <div class="product-price">${product.price.toLocaleString('fa-IR')} تومان</div>
        <div class="product-actions">
          <button class="btn-add" data-id="${product.id}">افزودن به سبد</button>
          <button class="btn-details" data-id="${product.id}">جزئیات</button>
        </div>
      `;
      productsContainer.appendChild(card);
    });

    pageInfo.textContent = `صفحه ${currentPage} از ${totalPages}`;
    btnPrev.disabled = currentPage === 1;
    btnNext.disabled = currentPage === totalPages;

    attachProductButtonsEvents();
  }

  function attachProductButtonsEvents() {
    const addButtons = document.querySelectorAll('.btn-add');
    const detailButtons = document.querySelectorAll('.btn-details');

    // callback ها
    addButtons.forEach((btn) => {
      btn.addEventListener('click', onAddToCartClick);
    });

    detailButtons.forEach((btn) => {
      btn.addEventListener('click', onDetailsClick);
    });
  }

  // --- منطق سبد خرید ---

  function findCartItemIndex(productId) {
    return cart.findIndex((item) => item.id === productId);
  }

  const getCartTotalCount = () =>
    cart.reduce((sum, item) => sum + item.qty, 0);

  const getCartTotalPrice = () =>
    cart.reduce((sum, item) => {
      const p = products.find((prod) => prod.id === item.id);
      return p ? sum + p.price * item.qty : sum;
    }, 0);

  function renderCartList() {
    cartList.innerHTML = '';
    if (!cart.length) {
      cartList.innerHTML = '<li class="muted">سبد خرید خالی است.</li>';
      return;
    }

    cart.forEach((item) => {
      const product = products.find((p) => p.id === item.id);
      const li = document.createElement('li');
      li.textContent = `${product.title} - تعداد: ${item.qty}`;
      cartList.appendChild(li);
    });
  }

  function updateCartSummary() {
    const totalCount = getCartTotalCount();
    const totalPrice = getCartTotalPrice();
    cartSummary.textContent =
      `سبد خرید: ${totalCount} کالا (جمع تقریبی: ${totalPrice.toLocaleString('fa-IR')} تومان)`;
  }

  function persistCart() {
    saveToLocalStorage('cartItems', cart);
  }

  // --- هندلر رویدادها ---

  function onAddToCartClick(event) {
    const id = Number(event.target.getAttribute('data-id'));
    const index = findCartItemIndex(id);
    if (index === -1) {
      cart.push({ id, qty: 1 });
    } else {
      cart[index].qty += 1;
    }

    // کلیک روی افزودن → در localStorage
    addClicksCounter.increment();
    updateClickStatsUI(); // همان لحظه UI آپدیت می‌شود

    persistCart();
    renderCartList();
    updateCartSummary();
  }

  function onDetailsClick(event) {
    const id = Number(event.target.getAttribute('data-id'));
    const product = products.find((p) => p.id === id);

    // کلیک روی جزئیات → در localStorage
    detailsClicksCounter.increment();
    updateClickStatsUI(); // همان لحظه UI آپدیت می‌شود

    alert(
      `جزئیات محصول:\n\n` +
      `${product.description}\n` 
    );
  }

  function onPrevClick() {
    if (currentPage > 1) {
      currentPage--;
      // کلیک روی صفحه قبل/بعد → در کوکی
      pageClicksCounter.increment();
      updateClickStatsUI(); // همان لحظه UI آپدیت می‌شود
      renderProducts(currentPage);
    }
  }

  function onNextClick() {
    const totalPages = Math.ceil(products.length / ITEMS_PER_PAGE);
    if (currentPage < totalPages) {
      currentPage++;
      // کلیک روی صفحه قبل/بعد → در کوکی
      pageClicksCounter.increment();
      updateClickStatsUI(); // همان لحظه UI آپدیت می‌شود
      renderProducts(currentPage);
    }
  }

  // --- آمار کلیک‌ها ---

  function updateClickStatsUI() {
    statAdd.textContent = addClicksCounter.get();
    statDetails.textContent = detailsClicksCounter.get();
    statPageClicks.textContent = pageClicksCounter.get();
  }

  // --- تخفیف تصادفی ۲٪ ---

  function maybeShowRandomDiscount() {
    const r = Math.random();
    if (r < DISCOUNT_PROBABILITY) {
      const percent = Math.floor(Math.random() * 30) + 1; // ۱ تا ۳۰
      discountBanner.style.display = 'block';
      discountBanner.textContent =
        `تبریک! شما یک کد تخفیف تصادفی ${percent}٪ دریافت کردید.`;
    } else {
      discountBanner.style.display = 'none';
    }
  }

  // --- بارگذاری محصولات از JSON (callback) ---

  function loadProducts(callback) {
    fetch('products.json')
      .then((res) => res.json())
      .then((data) => {
        products = data;
        callback(); // callback function
      })
      .catch((err) => {
        console.error('خطا در لود products.json', err);
        // fallback اگر JSON لود نشد - اینجا propertyها را با بقیه هماهنگ می‌کنیم
        products = [
          {
            id: 1,
            title: 'محصول پشتیبان',
            price: 1000,
            image: 'https://via.placeholder.com/200x150?text=Fallback',
            description: 'محصول پیش‌فرض در صورت مشکل در JSON'
          }
        ];
        callback();
      });
  }

  // --- مقداردهی اولیه ---

  function init() {
    // رویدادهای صفحه‌بندی
    btnPrev.addEventListener('click', onPrevClick);
    btnNext.addEventListener('click', onNextClick);

    updateClickStatsUI();
    maybeShowRandomDiscount();

    // لود محصولات از JSON و سپس رندر
    loadProducts(function () {
      const maxPage = Math.max(1, Math.ceil(products.length / ITEMS_PER_PAGE));
      if (currentPage > maxPage) currentPage = maxPage;

      renderProducts(currentPage);
      renderCartList();
      updateCartSummary();
    });
  }

  // اجرا
  init();

})();
