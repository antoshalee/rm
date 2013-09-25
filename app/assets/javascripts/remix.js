var remix = {};

// окно браузера
remix.win = new function () {

  var win = this;

  win.jqNode = $(window); // JQ объект окна браузера

  win.height = win.jqNode.height();
  win.width = win.jqNode.width();

  var onResizeFunction = []; // список функций, выполняемых при изменении размеров окна

  // добавить функцию в список выполнения при изменении размеров окна
  win.addResizeFunction = function (f) {
    onResizeFunction.push(f);
  };

  // пройти по списку и выполнить функции
  var onResize = function () {

    var newheight = win.jqNode.height();
    var newwidth = win.jqNode.width();

    if (newwidth===win.width && newheight===win.height) {

    var l = onResizeFunction.length;

    for (var i = 0 ; i < l; i=i+1) {
      onResizeFunction[i]();
    };

    };

    win.width = newwidth;
    win.height = newheight;

  };

  // назначить обработчик изменения размеров окна
  win.jqNode.bind('resize',onResize);

};
// end remix.win

// убрать "px" из css-величин
remix.cutPx = function (s) {
	var str = s.toLowerCase().replace('px','');
	if (/^\d+$/.test(str) ) {
		str = str * 1;
	}
	else {str = 0;};
  return str;
};

// тач-устройство
remix.isTouch = (('ontouchstart' in document.documentElement) || window.Touch) || false;

// получить горизонтальные метрики блока (отступы, ширина, границы)
remix.getHorMetrics = function(b) {

  var m = {},
      sum = 0,
      cutPx = remix.cutPx;

  // добавить занчение к сумме (занимаемой ширине блока)
  var addToSum = function (p) {
    var value = cutPx(p);
    sum = sum + value;
    return value;
  };

  m.marginLeft = addToSum(b.css('margin-left'));
  m.borderLeftWidth = addToSum(b.css('border-left-width'));
  m.paddingLeft = addToSum(b.css('padding-left'));
  m.width = addToSum(b.css('width'));
  m.paddingRight = addToSum(b.css('padding-right'));
  m.borderRightWidth = addToSum(b.css('border-right-width'));
  m.marginRight = addToSum(b.css('margin-right'));
  m.sum = sum;


  return m;

};

// выполняить действие при клике на элемент, определенный через event.target
remix.eventTargetAction = function (p) {

    var context = p.context,
        matchClass = p.matchClass,
        elementToActionClass = p.elementToActionClass,
        callback = p.callback;

    var contextClick = function (e) {

			var elem = false;
			var evTarget = e.target;
			var target = $(evTarget);

			if ((matchClass && evTarget.className.indexOf(matchClass) >= 0) || (elementToActionClass && evTarget.className.indexOf(elementToActionClass) >= 0)) {

				if (target.hasClass(elementToActionClass)) {
					elem = target;
				} else {
					elem = target.closest('.' + elementToActionClass);
				}

			};

			if (elem) {
				callback(elem);
			};

    };

    this.fireElement = function (elem) {
        contextClick({ target: elem[0] });
    };

    context.bind('click', contextClick);

};

// переключающиеся элементы: изменение состояния (css-класса) группы элементов в контейнере
remix.blockAccentSwitcher = function (p) {

	var context = p.context, // блок, содержащий переключающиеся элементы
			matchClass = p.matchClass, // все переключающиеся элементы и их "потомки" должны обладать css-классом, содержащим строку из matchClass
			elementToAccentClass = p.elementToAccentClass, // "родительский" элемент, на котром происходит изменение состояния
			accentedStateClass = p.accentedStateClass, // класс выделенного элемента
			alreadyAccentedStateQuery = p.alreadyAccentedStateQuery || false, // селектор для посика уже выделенного элемента
			currentSelected, // текущий выделенный элемент
			callback = p.callback;


	// выделить выбранный элемент, убрать выделение с текущего
	var changeElementState = function (elem) {

			if (!elem.hasClass(accentedStateClass)) {

					if (currentSelected) {currentSelected.removeClass(accentedStateClass);}
					currentSelected = elem;
					elem.addClass(accentedStateClass);

					if (callback) { callback(elem); }

			} else {
				currentSelected = elem;
			}

	};

	var eta = new remix.eventTargetAction({
			context: context,
			matchClass: matchClass,
			elementToActionClass: elementToAccentClass,
			callback: changeElementState
	});

	// выделить элемент при инициализации
	if (alreadyAccentedStateQuery) {
			var alreadySelected = context.find(alreadyAccentedStateQuery);
			if (alreadySelected.length > 0) {
					eta.fireElement(alreadySelected);
			}

	}


};

// переключние отображения блоков
remix.simpleBlockSwitch = function (p) {

	var simpleBlockSwitch = this,
			swithcer = p.swithcer, // jq-объект переключатель вида блока
			blocks = p.blocks; // переключаемые блоки

	// флаг — блоки показаны
	simpleBlockSwitch.showed = p.showed || false;

	// пройтись по блокам и выполнить функцию
	var iterateBlocks = function (blocks,callback) {

		var i = 0;

		while (blocks[i]) {
			callback(blocks[i]);
			i = i + 1;
		};

	};

	// показать блок
	var showBlock = function (block) {
		block.removeClass('na');
		simpleBlockSwitch.showed = true;
		if (p.afterShow) { p.afterShow(block); };
	};

	// скрыть блок
	var hideBlock = function(block) {
		block.addClass('na');
		simpleBlockSwitch.showed = false;
	};

	// переключить отображение блока
	var toggle = function (block) {

			if (!simpleBlockSwitch.showed) {
				showBlock(block);
			} else {
				hideBlock(block);
			}

	};

	// пройтись по блокам и переключить
	var toggleBlocks = function () {
			iterate(toggle);
	};

	// показать блоки
	simpleBlockSwitch.show = function () {
		iterateBlocks(blocks,showBlock);
		simpleBlockSwitch.showed = true;
	};

	// скрыть блоки
	simpleBlockSwitch.hide = function () {
		iterateBlocks(blocks,hideBlock);
		simpleBlockSwitch.showed = false;
	};

	// Назначить событие переключения отображения блока
	if (swithcer) {
		swithcer.bind('click', toggleBlocks);
	};


};


// блок с прокручиваемым содержимым
remix.scrollBlock = function (p) {

  var scrollBlock = this,
      jqNode = p.jqNode, // jq объект блока с прокруткой
      cellsContainer = jqNode.find(p.cellsContainerSelector), // контенйер содержимого для прокрутки (широкий блока)
      cellsSelector = p.cellsSelector, // селктор выборки блоков (колонок) — содержимого для прокрутки
      cells, // блоки (колони) — содержимое для прокрутки
      totalCellsWidth = 0, // общая ширина всех блоков для прокрутки
			fixNodeWidth = p.fixNodeWidth, // задать фиксированную ширину блока с прокруткой
			rightShadow = p.rightShadow,
      getHorMetrics = remix.getHorMetrics;

  scrollBlock.jqNode = jqNode;
  scrollBlock.inVieport = true; // содержимое блока умещается в его ширину

  // выбрать колонки внтури блока прокрутки
  var getCells = function () {
    cells = cellsContainer.find(cellsSelector);
  };

  scrollBlock.getCells = getCells;

  // установить css-метрики блока в px (преобразование % в px)
  var setMetrics = function (b) {

    var m = getHorMetrics(b);

    if (m.marginLeft !== 0) {b.css('margin-left',m.marginLeft+'px');};
    if (m.borderLeftWidth !== 0) {b.css('border-left-width',m.borderLeftWidth+'px');};
    if (m.paddingLeft !== 0) {b.css('padding-left',m.paddingLeft+'px');};
    if (m.width !== 0) {b.css('width',m.width+'px');};
    if (m.paddingRight !== 0) {b.css('padding-right',m.paddingRight+'px');};
    if (m.borderRightWidth !== 0) {b.css('border-right-width',m.borderRightWidth+'px');};
    if (m.marginRight !== 0) {b.css('margin-right',m.marginRight+'px');};

    return m; // доступна общая ширина блока со всеми отступами

  };

  // создать прокручивающийся блок
  var make = function () {

		// сбросить ширину контейнера
		cellsContainer.css('width','auto');

		// задать ширину блоку с прокруткой
		if (fixNodeWidth) {
			jqNode.css('width','auto')
						.css('width',jqNode.css('width'));
		};

    var crnt, l = cells.length;

    totalCellsWidth = 0;

    // сбросить установленные метрики у контенйера колонок
    cellsContainer.attr('style','');

    // пройти по блокам-колнкам
    for (var i = 0; i < l; i=i+1) {
      crnt = $(cells[i]); // текущий блок-колонка
      crnt.attr('style',''); // сбросить метрики блока-колонки
      // добавить ширину текущего блока в общую сумму
      totalCellsWidth = setMetrics(crnt).sum /*установить метрики и получить общую ширину блока*/ + totalCellsWidth;
    };

    // если общая ширина всех блоков-колонок больше чем ширина области просмотра,
    // то установить для неё стиль блока спрокруткой
    if (totalCellsWidth > 0 && totalCellsWidth > remix.cutPx(jqNode.css('width'))) {

      // установить css-метрики контейнеру колонок (широкому блоку) (например, преобразовать отрицательный margin в % в px)
      setMetrics(cellsContainer);
      // ширина контенйера равна обще ширине всех колонок
      cellsContainer.css('width',totalCellsWidth  + 'px');

      jqNode.addClass('scbl-over-x');

			//добавить белое затенение
			if (rightShadow) {
				jqNode.addClass('scbl-over-x-shadow');
			};

			// содержимое не поместилось в блок
      scrollBlock.inVieport = false;

    } else {
			// убрать прокрутку
      jqNode.removeClass('scbl-over-x');

			// вернуть ширину
			if (fixNodeWidth) {
				jqNode.css('width','auto');
			};

			// убрать белое затенение
			if (rightShadow) {
				jqNode.removeClass('scbl-over-x-shadow');
			};

			// содержимое поместилось в блок
      scrollBlock.inVieport = true;
    };

  };

  scrollBlock.make = make;

  getCells();
  make();

  // если передан параметр, то пересчитывать метрики блоков при изменении размеров окна
  if (p.onWinResize) {
    remix.win.addResizeFunction(make);
  }

};
// end remix.scrollBlock

/*
remix.initScrollBlocks = function () {

  var scbl = $('div.scbl');

  scbl.each(function(){
    new remix.scrollBlock({
      jqNode: $(this),
      cellsContainerSelector: 'div.scbl-cnt',
      cellsSelector: 'div.scbl-cell',
      onWinResize: true
    });

  });

};
*/

// блоки прокрутки с кристаллом
remix.gemScroll = function (p) {

  var gemScroll = this,
      jqNode = p.jqNode, // блок с прокруткой
      cellsContainerSelector = p.cellsContainerSelector, // селектор контенера колонок (широкий блок)
      cellsSelector = p.cellsSelector; // блоки-колонки, содержимое для прокрутки

  // создать прокурчивающийся блок
  var scorllBlock = new remix.scrollBlock({
      jqNode: jqNode,
      cellsContainerSelector: cellsContainerSelector,
      cellsSelector: cellsSelector,
			rightShadow: true
 });

 // создать прокурчивающийся блок с кристаллом
 var makeCustomScrollbar = function () {

   if (!scorllBlock.inVieport) { // если содержимое прокручивающегося блока больше его ширины

     // создать кастомный скроллбар
     scorllBlock.jqNode.mCustomScrollbar({
      horizontalScroll:true,
      autoDraggerLength:false,
      mouseWheel: false,
      contentTouchScroll: true,
      scrollInertia: 0,
      scrollButtons:{
        enable:true
      },
      advanced:{
          updateOnBrowserResize: false,
          updateOnContentResize: false
      }
    });

   };

 };

 makeCustomScrollbar();

 // при изменении размеров окна убрать прокрутку с кристаллом, пересчитать метрики прокручивающегося блока
 var onWinResize = function () {
   if (scorllBlock.jqNode.mCustomScrollbar) {
     scorllBlock.jqNode.mCustomScrollbar('destroy');
   }
   scorllBlock.make();
   makeCustomScrollbar();
  };

  remix.win.addResizeFunction(onWinResize);


};
// end remix.gemScroll

// блоки  прокурткой в виде кристалла
remix.initGemScrolls = function (p) {

  var scbl = p.container.find('div.scbl');

  scbl.each(function(){
    new remix.gemScroll({
      jqNode: $(this),
      cellsContainerSelector: 'div.scbl-cnt',
      cellsSelector: 'div.scbl-cell'
    });

  });

};
// end remix.initGemScrolls

// "перекрывающий блок", отображаемый поверх контента страницы над определенным элементом
remix.overBlock = function (p) {

  var overBlock = this,
      jqNode, // jq объект блока
      cssClass = p.cssClass, // css класс блока
      fadeDuration = 500, // длительность анимации появления/растворения
      onHideCallback = p.onHideCallback;

  overBlock.inAnimation = false; // идёт анимация блока

  // спозиционировать перекрывающий блок над переданным блоком
  var position = function (p) {

    var winScrollTop = remix.win.jqNode.scrollTop(), // вертикальная прокрутка окна
        winHeight = remix.win.height, // высота окна
        winWidth = remix.win.width, // ширина окна
        width = 0, // ширина блока
        height = 0, // высота блока
        cssTop = 0, // верхняя координата блока
        cssLeft = 0; // левая координата блока

    // отображается ли блок
    var isShowed = jqNode.is(':visible');

    // вывести блок из области просмотра
    jqNode.css({
      'left':'-9999px',
      'top':'-9999px'
    });

    jqNode.addClass('vis-h')
          .show();

    // получить метрики блока
    width = jqNode.width();
    height = jqNode.height();

    // целевой блок, над которым необходимо спозиционировать
    var fromBlock = p.fromBlock,
        fromBlockOffset = fromBlock.offset(); // координата целевого блока

    // координаты цента целевого блока
    var fromBlockCenterTop = fromBlockOffset.top + fromBlock.height() * 0.5;
    var fromBlockCenterLeft = fromBlockOffset.left + fromBlock.width() * 0.5;

    // совеместить координаты центра перекрывающего блока с целевым
    cssTop = fromBlockCenterTop - height * 0.5;
    cssLeft = fromBlockCenterLeft - width * 0.5;

    // если блок выходит выше области просмотра
    if (cssTop < winScrollTop) {
      cssTop = winScrollTop + 10; // сдвинуть блок ниже области просмотра
    };

    // если блок выходит ниже области просмотра
    if ( (cssTop + height) > (winScrollTop + winHeight) ) {
      cssTop = winScrollTop + winHeight - height - 10;
    };

    // если блок выходит левее области просмотра
    if (cssLeft < 0) {
      cssLeft = 10;
    };

    // если блок уходит правее области просмотра
    if ( (cssLeft + width) > winWidth ) {
      cssLeft = winWidth - width - width * 0.05 ;
    };

    // задать координаты перекрывающего блока
    jqNode.css({
      'left':cssLeft+'px',
      'top':cssTop+'px'
    });

    // скрыть блок, если он был скрыт изначально
    if (!isShowed) {
      jqNode.hide();
    };

    // включить отображение блока
    jqNode.removeClass('vis-h');

  };

  // показать блок
  overBlock.show = function (p) {

    // рассчитать координаты над целевым блоком
    position({fromBlock: p.fromBlock});

    overBlock.inAnimation = true;

    // показать блок
    jqNode.fadeIn(fadeDuration,function(){
      overBlock.inAnimation = false;
    });


  };

  //скрыть блок
  overBlock.hide = function () {

    if (onHideCallback) {
      onHideCallback();
    };

    overBlock.inAnimation = true;

    jqNode.fadeOut(fadeDuration,function(){
      overBlock.inAnimation = false;
    });


  };

  // скрыть блок без анимации
  overBlock.forceHide = function() {
    jqNode.stop().hide();
    overBlock.inAnimation = false;
    if (onHideCallback) {
      onHideCallback();
    };
  };

  // init

  jqNode = $('<div class="'+cssClass+'" />');
  $('body').append(jqNode);
  jqNode.hide();

  if (p.blockToAppend) {
    jqNode.append(p.blockToAppend);
  };

  // скрывать блок при нажатии
  //jqNode.bind('click',overBlock.hide);

};
// end remix.overBlock

// объект для загрузки картинок
remix.DynamicImage = function () {

  var DynamicImage = this,
      iCntNode = $('<div />'),
      iNode = $('<img />'),
      iSrc,
      inLoadCallBack;

  var onLoad = function () {

    if (inLoadCallBack) {
      inLoadCallBack();
    }
  };

  // выполнить загрузку картинки и callback после загрузки
  DynamicImage.load = function (p) {

    iSrc = p.src;

    iNode.attr('src',iSrc);

    if (p.inLoadCallBack) {
      inLoadCallBack = p.inLoadCallBack;
    } else {
      inLoadCallBack = false;
    }

  };

 // расчитать размеры картинки внутри контейнера с заданными размерами
 DynamicImage.getSizedImgMetrics = function (p) {

    var metrics = {},
        maxwidth = p.maxwidth,
        maxheight = p.maxheight;

    // задать размеры контейнера
    iCntNode.width(maxwidth);
    iCntNode.height(maxheight);

    // отобразить контейнер и вывести из потока документа
    iCntNode.addClass('dynamic-image-cnt-metrics-calc');
    // показать картинку, вписать в блок
    iNode.addClass('dynamic-image-cnt-metrics-calc-i');

    // записать размеры картинки
    metrics.width = iNode.width();
    metrics.height = iNode.height();

    // скрыть картинку и блок
    iNode.removeClass('dynamic-image-cnt-metrics-calc-i');
    iCntNode.removeClass('dynamic-image-cnt-metrics-calc');

    return metrics;

  };

  // добавить блок с изображением в документ
  iCntNode.addClass('dynamic-image');
  iNode.addClass('dynamic-image');
  iNode.bind('load',onLoad);
  iCntNode.append(iNode);
  $('body').append(iCntNode);

};
// end remix.DynamicImage

// ссылка на большое фото изделия
remix.GoodsGridFullViewLink = function(p) {
  console.log('here')

  var GoodsGridFullViewLink = this,
      jqNode = p.jqNode, // jq объект ссылки-блока
      iCntNode = jqNode.find('div.goods-grid-i-cnt'), // контейнер картинки изделия внутри ссылки-блока
      imgNode = iCntNode.find('img'); // картинка изделия внутри ссылки-блока

  // внешние сслыки на поля объекта
  GoodsGridFullViewLink.jqNode = jqNode;
  GoodsGridFullViewLink.url = jqNode.attr('data-url'); // адрес большого фото

  // добавить индикатор загрузки к блоку-ссылке
  GoodsGridFullViewLink.setLoader = function () {
    jqNode.addClass('goods-grid-item-toview-onload');
    iCntNode.addClass('loader-b loader32x32'); // показать индикатор
    imgNode.addClass('vis-h'); // скрыть картинку
  };

  // убрать индикатор загрузки
  GoodsGridFullViewLink.unSetLoader = function () {
    jqNode.removeClass('goods-grid-item-toview-onload');
    iCntNode.removeClass('loader-b loader32x32'); // скрыть индиктор
    imgNode.removeClass('vis-h'); // показать картинку
  };

  /*
  var onClick = function () {

    if (p.onClick) {
      p.onClick(GoodsGridFullViewLink);
    }

  };

  jqNode.bind('click',onClick);

  */

};

// просмотр больших фото изделий из коллекци
remix.GoodsGridFullViewsManager = function (p) {

  var container = p.container;

  if (!container || container.length <= 0) {
    return;
  };

  var curFullViewLink; // текущая (последняя открытая) ссылка на большое фото
  var lastImgLoadFunction; // функция, выполняемая при загрузке последней картинки
  // при запросе нескольких картинок, callback загрузки последней картиники записыватся в эту переменную
  // позволяет избежать показа нескольких фото при быстром нажатии подряд нескольких ссылок

  // картинка изделия
  var fullImage = $('<img class="goods-grid-item-full-view-i" />');
  // контейнер картинки изделия
  var fullImageCnt = $('<div class="goods-grid-item-full-view-i-cnt" />');
	// крестик для скрытия блока
	var closeCnt = $('<div class="goods-grid-item-full-view-close"><span class="ico clcross-ico" /></div>');
  // блок с ссылками «поделиться»
	var shareCnt = $('<div class="goods-grid-item-full-view-share" />');

  fullImageCnt.append(fullImage,closeCnt);

  // объект для подгрузки картинок
  var dynamicImage = new remix.DynamicImage();

  // действие при закрытии блока просмотра большого фото
  var onHideFullViewBlock = function () {

    // убрать индикатор загрузки у текущего изделия
    if (curFullViewLink) {
      curFullViewLink.unSetLoader();
    }

  };

  // блок, показываемый над контентом страницы
  var fullViewBlock = new remix.overBlock({
    blockToAppend: fullImageCnt, // показать контейнер картинки
    onHideCallback: onHideFullViewBlock,
    cssClass: 'goods-grid-item-full-view'
  });

	// скрыть блок при нажатии на крестик
	closeCnt.bind('click',function(){
		fullViewBlock.hide();
	});

  // полкчить допустные размеры для блока внутри окна браузера
  var getWinMetrics = function () {

    var winMetrics = {};

    // доступная ширина 80% окна
    winMetrics.width = remix.win.width * 0.8;
    // но не более 720px
    if (winMetrics.width > 720) { winMetrics.width = 720; };

    winMetrics.height = remix.win.height * 0.8;
    if (winMetrics.height > 720) { winMetrics.height = 720; };

    return winMetrics;

  };

  // действие при загрузке очредного фото
  var execLastOnImgLoad = function () {
    lastImgLoadFunction();
  };

  // callback при загрузке фото
  var onImgLoad = function(fullViewLink) {

    var winMetrics = getWinMetrics();

    // расчитать допустимые размеры картинки внутри окна
    var imgMetrics = dynamicImage.getSizedImgMetrics({
      maxwidth: winMetrics.width + 2,
      maxheight: winMetrics.height + 2 //+ 30 // отступ для кнопок «поделиться»
    });

    // картинка загружена -> установить src фото большой фотографии изделия
    fullImage.attr('src',fullViewLink.url);

    // задать размеры фото изделия
    fullImage.width(imgMetrics.width);
    fullImage.height(imgMetrics.height);

		// добавиить кнопки «поделиться»
    var buttonsHtml =
			'<span class="f13 mr10 ib">Поделиться:</span>'
    + '<a class="ib ophv va-m mr8" href="#"><span class="ico fb-ico20"></span></a>'
    + '<a class="ib ophv va-m mr8" href="#"><span class="ico vk-ico20"></span></a>'
    + '<a class="ib ophv va-m" href="#"><span class="ico tw-ico20"></span></a>';

		shareCnt.html(buttonsHtml);

    // показать блок с фото, передать вызывающую ссылку-блок
    fullViewBlock.show({fromBlock:fullViewLink.jqNode});



    // последняя нажатая ссылка-блок на фото
    curFullViewLink = fullViewLink;

  };

  // клик на ссылку-блок для показа большого фото
  var fullViewBlockClick = function () {

    // предотвартить срабатывание, пока идёт анимация появления/скрытия блока
    if (fullViewBlock.inAnimation) {
      return;
    };

    // создать объект-ссылку
    var fullViewLink = new remix.GoodsGridFullViewLink({
      jqNode: $(this)
    });

    // скрыть блок большого фото
    fullViewBlock.forceHide();

    // показать индикатор загрузки ссылки-блока
    fullViewLink.setLoader();

    // записать последнее загруженно фото из ссылки-блока
    lastImgLoadFunction = function () {onImgLoad(fullViewLink);};

    // загрузить картинку, выполнить показ картинки, вызванный последней нажатой ссылкой
    dynamicImage.load({
      src: fullViewLink.url,
      inLoadCallBack: execLastOnImgLoad
    });


  };
	// end fullViewBlockClick

  // блоки-ссылки на большие фото изделий
  container.find('div.goods-grid-item-toview').bind('click',fullViewBlockClick);

  /*
  $('div.goods-grid-item-toview').each(function(){

    new remix.GoodsGridFullViewLink({
      jqNode: $(this),
      onClick: fullViewBlockClick
    });

  });
   */

  // при изменении размеров окна пересчитать расположение блока большого фото
  var onWinResize = function () {
    execLastOnImgLoad();
  };

  remix.win.addResizeFunction(onWinResize);

};
// end remix.GoodsGridFullViewsManager

// фильтры списка лотов
// простые выпадающие списки
remix.simpleDropDowns = function (p) {

	var context = p.context;

	if (context.length <=0) {
		return;
	};

  var lastelem = false;

	var toggle = function (elem) {

    var cnt = elem.next();

    if (cnt.is(':visible')) {

      cnt.stop().fadeOut(250,function(){lastelem = false;});

    } else {

      if (lastelem && lastelem.is(':visible')) {
        lastelem.hide();
      };

      cnt.stop().fadeIn(250,function(){lastelem = cnt;});
    }


	};

	var sddevt = new remix.eventTargetAction({
		context:context,
		matchClass: 'drop-down-btn',
		elementToActionClass: 'drop-down-btn',
		callback: toggle
	});


};
// end remix.SimpleDropDowns

// обертка для палагина "magnificPopupGallery" фотогалерей
remix.magnificPopupGallery = function (p) {

  p.container.magnificPopup({
  delegate: p.linkSelector, // показ галереи по ссылке
  type: 'image',
  tClose: 'Закрыть',
  tLoading: '<span class="font14">Загрузка…</span>',
  gallery: {
    enabled: true,
    navigateByImgClick: true,
    arrowMarkup: '<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"></button>',
    tPrev: 'Предыдущая',
    tNext: 'Следующая',
    tCounter: '<span class="f13">%curr% из %total%</span>',
    preload: [0,2]
  },
  image: {
    cursor: 'default',
    tError: '<span class="f13"><a href="%url%">Картинка</a> не загружена<br />Попробуйте позже</span>'
  },
  ajax: {
    tError: '<span class="f13"><a href="%url%">Картинка</a> не загружена<br />Попробуйте позже</span>'
  },
  callbacks: {

    // действие при смене фото
    change: function () {

			var toShareCnt = this.contentContainer;

      if (p.onChange) {
          p.onChange.call(this, {toShareCnt:toShareCnt});
        }
    }

  }

});

};
// end remix.magnificPopupGallery

// лайтбокс "magnificPopupGallery" для фото галерей
remix.magnificPopupGalleryOnPage = function (p) {

  if (!(p.container || p.container.length <=0)) {
    return;
  };

  // контейнер фотогалереи
  var galCnts = p.container.find('div.photo-grid');

  // при смене фото, вставить кнопки "поделиться" в блок описания фотографии
  var slideChange = function (p) {

    var popupObject = this;
    console.log(popupObject)
    var urlToShare = $(popupObject.currItem.el).data("album-url");
    if (!urlToShare) urlToShare = location.href;


		if (!p.toShareCnt) {return;}

			var buttonsCnt = p.toShareCnt.find('#photoShare');

			if (buttonsCnt.length <=0) {
				buttonsCnt = $('<div id="photoShare" class="ph-g-i-share" />');
				p.toShareCnt.append(buttonsCnt);
			} else {
				buttonsCnt.empty();
			}

    twitterParams = "url=" + encodeURIComponent(urlToShare);

    var buttonsHtml =
			'<span class="f13 mr8 white">Поделиться:</span>'
    + '<span id="vk_btn_container" class="ophv" style="display: inline-block; position: relative; vertical-align: middle; margin-right: 10px"></span>'
		+ '<a class="ib ophv va-m mr10" href="#" id="fb_share_btn"><span class="ico fb-ico20"></span></a>'
    + '<a class="ib ophv va-m" href="https://twitter.com/share?' + twitterParams + '" target="_blank"><span class="ico tw-ico20"></span></a>';


		buttonsCnt.html(buttonsHtml);

    buttonsCnt.find('#vk_btn_container').html(VK.Share.button(
      {url: urlToShare, image: popupObject.currItem.src},
      {type: 'custom', text: '<span class="ico vk-ico20"></span>'}));

    // p.toShareCnt.on('click', '#photoShare', function() {
    //   return false;
    // });

    p.toShareCnt.on('click', '#fb_share_btn', function(){
      window.open(
      'https://www.facebook.com/sharer/sharer.php?u=' +
      encodeURIComponent(urlToShare),
      'facebook-share-dialog',
      'width=626,height=436');
      return false;
    })

    // !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");


  };

    // создать галерею для фото внутри контейнера
    galCnts.each(function(){
     remix.magnificPopupGallery({ // обертка для палагина "magnificPopupGallery"
      container: $(this),
      linkSelector: 'a.ph-g-i-l', // сслыки на фото
      onChange:slideChange // вставка кнопок "поделиться" при смене фото
    });

    });



};

// слайдер на осонове плагина bxslider
remix.createSlider = function (p) {

  var jqNode = p.node.find('div.slider-content'); // плагин работает со внутренним контейнером
  var nodePrnt = jqNode.parent();
  var slider;
  var sliderParams = p.sliderParams || {};
	var pagerNode;

  // добавить индикатор загрузки
  nodePrnt.addClass('loader-b loader32x32');

	/*
  var imgs = jqNode.find('img'); // картинки в блоке слайдера
  var imgsTotal = imgs.length; // всего картинок
  var imgsLoaded = 0; // счётчик загруженных картинок
	*/


	// действие при готовности слайдера
	var onSliderLoad = function () {
    // удалить инидикатор загрузки
    nodePrnt.removeClass('loader-b loader32x32');
		 // отобразить контнйер
		jqNode.css('visibility','visible');
	};

  // создать слайдер
  var makeSlider = function () {

		sliderParams.onSliderLoad = onSliderLoad; // действие при готовности слайдера

    slider = jqNode.bxSlider(sliderParams); // bxslider

		// "скачает" блок с точками слайдов, зафиксировать ширину контейнера
		var bxcontrols = nodePrnt.find('div.bx-controls');
		bxcontrols.css('width','100%');
		bxcontrols.css('width',bxcontrols.css('width'));

      // клик на "пейджере" запускает смену слайдов

			if (sliderParams.auto) {
        pagerNode = nodePrnt.find('div.bx-pager');
        pagerNode.bind('click',function(){
          slider.startAuto();
        });
      }

  };

  // пересчитать высоту родителя
  var makeAndCalcHeight = function () {
    if (p.heightRatio) { // если передан множитель высоты

    // если слайдер уже создан
    if (slider) {
      slider.destroySlider(); // удалить bxslider
			jqNode.css('visibility','hidden'); // спрятать контейнер
			if (pagerNode) {
				pagerNode.unbind('click');
				pagerNode = null;
			}
    }

    nodePrnt.height(nodePrnt.width()* p.heightRatio); // пересчитать высоту контейнера

    // созадть сдайдер
    makeSlider();

    };

  };

  // инициализация слайдера
  var init = function () {

    // создать слайдер
    makeAndCalcHeight();

    // если не тач-устройство, пересчитывать высоту контейнера при измении размеров окна
    if (!remix.isTouch) {
      remix.win.addResizeFunction(makeAndCalcHeight);
    }

  };

	/*
  var imgLoad = function() {

    imgsLoaded = imgsLoaded + 1;  // при загрузке картинки увеличить счётчик
    if (imgsTotal === imgsLoaded) { // если все картинки загружены создать слайдер
			alert(imgsTotal+' '+imgsLoaded);
			init();
    }
  };

	imgs.each(function(){
		var img = $(this);
		img.bind('load',imgLoad);
		img.attr('src',img.attr('src'));
	});
	*/

 init();

};
// end remix.createSlider

// слайдеры на всю ширину страницы
remix.wideSlidersOnPage = function (p) {

  var blocks = p.container.find('div.wideslider');

	var mode;
				//,speed;

	if (remix.isTouch) {
		mode = 'horizontal';
		//speed = 750;
	} else {
		mode = 'fade';
		//speed = 750;
	};


  if (blocks.length > 0) {
    blocks.each(function(){
      remix.createSlider({
        node:$(this),
        sliderParams: {
					auto: true,
          controls:false,
					mode: mode,
					oneToOneTouch: false,
					pause:5000,
					speed:750
        },
        heightRatio: 0.34 // "псевдо-резина" высота блока слайдера = 0,34 ширины
      });
    });
  }

};

// слайдер акций на главной
remix.actionsSliderOnMain = function () {

  var cnt = document.getElementById('sp-promos-slides');

  if (!cnt) {
    return;
  };

  remix.createSlider({
    node:$(cnt),
    sliderParams: { // параметы плагина bxslider
			auto: true, // слайд-шоу
      controls:false, // отключить ссылки "пред.", "след."
			oneToOneTouch: false,
      pause:5000 // пауза между кадрами
    },
    heightRatio: 0.53 // "псевдо-резина" высота блока слайдера = 0,53 ширины
  });

};
// end remix.actionsSliderOnMain

// сворачиваемый/разворачиваемый блок
remix.heightSlideBlock = function (p) {

  var heightSlideBlock = this,
      block = p.block, // jq объект блока
      blockOpenClass = p.blockOpenClass, // класс блока в развернутом состоянии
      contentBlock = p.contentBlock || block.find('div.hsb-content'), // контйенер контента выпадающего блока
      closedBlockHeight = p.closedBlockHeight || 0, // высота блока в свернутом состоянии
      afterShow = p.afterShow, // действие после показа блока
      afterHide = p.afterHide, // действие после скрытия блока
      duration = p.duration || 500, // длительность анимций сворачивания/разворачивания
      inAnimate = false; // идёт анимация

      heightSlideBlock.isShow = p.isShow || false; // блок в скрытом/раскрытом состоянии

  // действие после показа блока
  var showCallback = function () {

    // задать класс развернутого состояния
    if (blockOpenClass) {
      block.addClass(blockOpenClass);
    };

    // сбросить высоту и обрезку при переполнениии
    block.css({
      'height':'auto',
      'overflow':'visible'
    });

    // анимация закончилась
    inAnimate = false;

    // блок показан
    heightSlideBlock.isShow = true;

    if (afterShow) {
      afterShow();
    };

  };

  var hideCallback = function () {

    // убрать класс открытого состояния
    if (blockOpenClass) {
      block.removeClass(blockOpenClass);
    };

    inAnimate = false;

    // блок скрыт
    heightSlideBlock.isShow = false;

    if (afterHide) {
      afterHide();
    };

  };


  // раскрыть блок
  var show = function () {

    // предотвратить срабатывания пока идёт другая анимация
    if (inAnimate) {
      return;
    }

    // блок разворачивается до высоты внутренного содержимого
    var contentHeight = contentBlock.height();

    inAnimate = true;

    block.stop().animate(
            {
              'height':contentHeight+'px'
            },
            duration,
            showCallback
          );

  };

  // внешнаяя ссылка на метод показа блока
  heightSlideBlock.show = show;

  // свернуть блок
  var hide = function () {

    // предотвратить срабатывания пока идёт другая анимация
    if (inAnimate) {
      return;
    }

    // содержимое скрывается внутри блока
    block.css({
      'overflow':'hidden'
    });

    inAnimate = true;

    block.stop().animate(
            {
              'height':closedBlockHeight+'px'
            },
            duration,
            hideCallback
          );
  };

  // внешнаяя ссылка на метод скрытия блока
  heightSlideBlock.hide = hide;

	// если передан элемент для скрытия блока
	if (p.closeActor) {
		// назначить коллбэк по щелчку
		block.on('click',p.closeActor,p.closeActorCallback);
	};

};
// end remix.heightSlideBlock

// ссылка показывающая/скрывающая выпадающий блок
remix.heightSlideBlockActor = function (p) {

  var jqNode = p.jqNode, // jq Объект ссылки
      iconNode = p.iconNode, // значок в ссылке
      txtNode = p.txtNode, // текстовый блок ссылки
      onOpenClass = p.onOpenClass, // класс ссылки в развернутом состоянии блока
      onCloseClass = p.onCloseClass, // класс ссылки в свернутом состоянии блока
      iconOnOpenClass = p.iconOnOpenClass, // класс значка в развернутом состоянии блока
      iconOnCloseClass = p.iconOnCloseClass, // класс значка в свернутом состоянии блока
      txtOnOpen = p.txtOnOpen, // текст в развернутом состоянии блока
      txtOnClose = p.txtOnClose, // текст  в свернутом состоянии блока
      onClose = p.onClose,
      onOpen = p.onOpen,
			toggledBlockCloseElement = p.toggledBlockCloseElement, // элемент, сворачивающий блок
			heightSlideBlockParams = 	p.heightSlideBlockParams; // параметры выпадающего блока


  // выпадающий блок
  var toggledBlock;

  // развернуть блок
  var open = function () {

    // действие перед разворачиванием блока
    if (p.beforeOpen) {
      p.beforeOpen();
    };

    // показать значок развернутого состояния
    if (iconNode && iconOnOpenClass) {
      iconNode.attr('class',iconOnOpenClass);
    }

    // текст развернутого состояния
    if (txtNode && txtOnOpen) {
      txtNode.html(txtOnOpen);
    };

    // задать класс открытого состояния
    if (onOpenClass) {
      jqNode.addClass('onOpenClass');
    };

    // убрать класс закрытого состояния
    if (onCloseClass) {
      jqNode.removeClass('onOpenClass');
    }

    if (onOpen) {
      onOpen();
    }

    // развернуть блок
    toggledBlock.show();

  };

  // свернуть блок
  var close = function () {

    // перевести значок в закрытое состояние
    if (iconNode && iconOnCloseClass) {
      iconNode.attr('class',iconOnCloseClass);
    }

    // текст закрытого состояния
    if (txtNode && txtOnClose) {
      txtNode.html(txtOnClose);
    };

    // ссылка в зкрытом состоянии
    if (onCloseClass) {
      jqNode.addClass('onOpenClass');
    }

    // убрать класс открытого состояния
    if (onOpenClass) {
      jqNode.removeClass('onOpenClass');
    };

    if (onClose) {
      onClose();
    }

    // скрыть блок
    toggledBlock.hide();


  };

   // клик на ссылке
  var actorClick = function () {

    // блок свернут -> показать
    if (!toggledBlock.isShow) {
      open();
      return;
    };

    // блок развернут -> скрыть
    if (toggledBlock.isShow) {
      close();
      return;
    };

  };

	// если передан элемент для сворачивания блока
	if (toggledBlockCloseElement) {
		heightSlideBlockParams.closeActor = toggledBlockCloseElement; // задать элемнет
		heightSlideBlockParams.closeActorCallback = close; // выполнить коллбэк на "сворачивающем" элементе
	};

  // выпадающий блок
  toggledBlock = new remix.heightSlideBlock(heightSlideBlockParams);

  jqNode.bind('click',actorClick);

};
// end remix.heightSlideBlockActor

// ссылки "ещё фотографии" в списке фото галереи
remix.photoGridLinks = function (p) {

  var nodes = p.container.find('a.js-phb-tggl');

  if (nodes.length <= 0) {
    return;
  };

  var photoGridLink = function (p) {

    var link = p.link,
        block = p.block;

    //var minimShowed = false;

    /*
    var showMinimizedItems = function () {
      if (!minimShowed ) {
        block.find('div.photo-grid-minimized-items')
                   .removeClass('photo-grid-minimized-items');
        minimShowed = true;
      }
    };
    */

   if ((!link && !block)||(link.length<=0 || block.length <=0)) {
     return;
   }

    // объект-ссылка показывающий/скрывающий выпадающий блок
    new remix.heightSlideBlockActor({
      jqNode: link,
      iconNode: link.find('span.js-btgl-icon'), // значки "стрелочка", "сетка"
      txtNode: link.find('span.js-btgl-txt'), // блок текста "Свернуть", "Смотреть все фото"
      iconOnOpenClass: 'ico minimize-ico mr4', // значок "стрелочка"
      iconOnCloseClass: 'ico show-photo-ico mr4', // значок "сетка фото"
      txtOnOpen: 'Свернуть',
      txtOnClose: 'Смотреть все фото',
      heightSlideBlockParams: {
        block: block,
        closedBlockHeight: block.height()
      }
    });

  };

  nodes.each(function(){

    var crnt = $(this);

    new photoGridLink({
      link: crnt,
      block: $('#'+crnt.attr('data-gallery-id'))
    });

  });


};

// ссылки, показывающие/скрывающие выпадающие блоки
remix.heightSlideBlockLinks = function (p) {

  // контейнер, содержащий ссылки
  var container = p.container;

  if (!container || container.length <= 0) {
    return;
  };

  var links = container.find('a.hsb-link');
  links.each(function(){

    var link = $(this);
    var block = $("#"+link.attr('data-hsb-block')); // id блока в атрибуте ссылки

    // ссылки, исчезающие при показе блока
    if (link.hasClass('hsb-link-hided')) {

      var hideLink = function () {
        link.fadeOut(500);
      };

      // объект-ссылка показывающий/скрывающий выпадающий блок
      new remix.heightSlideBlockActor({
        jqNode: link,
        beforeOpen: hideLink,
        heightSlideBlockParams: { // выпадающий блок
          block: block
        }
      });

    } else { // обычные ссылки-переключатели

      // объект-ссылка показывающий/скрывающий выпадающий блок
      new remix.heightSlideBlockActor({
        jqNode: link,
        heightSlideBlockParams: { // выпадающий блок
          block: block
        }
      });

    }

  });

};
// end remix.heightSlideBlockLinks

// прилипающее верхнее меню
remix.stickyTopMenu = function () {

$('#top-nav').waypoint('sticky', {
  stuckClass: 'topnav-sticky'
});

};
// end remix.stickyTopMenu

// прокрутка новостей на главной
remix.startNewsScroll = function () {

	var scrollBlock = $('#sp-news'), slider;


	var processBlock = function(){

		if (slider){
			slider.destroySlider();
		};

		slider = scrollBlock.bxSlider({
			slideSelector: 'div.fl',
			nextSelector: '#sp-news-right',
			prevSelector: '#sp-news-left',
			nextText: ' ',
			prevText: ' ',
			pager: false,
			responsive:false
		});

	};

	processBlock();

	remix.win.addResizeFunction(processBlock);


};
// remix.startNewsScroll

// карта на стартовой странице
remix.mapOnStartPage = function (p) {
  // контейнер карты
  var mapCnt = document.getElementById(p.mapCntId);

  if (!mapCnt) {
    return ;
  };


  // ссылка с координатами
  var coordLink = function(p) {

    var coordLink = this,
        jqNode = p.jqNode,
        cssActiveClass = p.cssActiveClass, // класс выбранной ссылки
        onClickCallback = p.onClickCallback; // действие по клику на ссылку

    coordLink.latitude = jqNode.attr('data-latitude'); // широта
    coordLink.longitude = jqNode.attr('data-longitude'); // долгота

    coordLink.title = jqNode.find('div.h-item').text(); // текст название точки на карте
    //coordLink.addr = jqNode.find('span.sp-address-value').text(); // адрес точки на карте

    coordLink.selected = false; // ссылка не выбрана

	// выбрать ссылку
    coordLink.select = function () {
      jqNode.addClass(cssActiveClass);
      coordLink.selected = true;
    };

	// отменить выбор ссылки
    coordLink.unSelect = function () {
      jqNode.removeClass(cssActiveClass);
      coordLink.selected = false;
    };

    var onClick = function () {
      onClickCallback(coordLink);
    };

    jqNode.bind('click',onClick);

  };

	var mapObj; // объект карты
  var curCoordLink; // текущая выбранная ссылка
  var placeMark; // метки на карте

  // установить метку на карту
  var setMapMark = function(p) {

    if (!mapObj) {return;};

		if (placeMark) {placeMark.setMap(null);};

		placeMark = new google.maps.Marker({
				position: new google.maps.LatLng(p.latitude,p.longitude),
				map: mapObj,
				title:p.text
		});

		mapObj.setCenter(placeMark.getPosition());


		// yandex maps
		/*
    if (placeMark) { // убрать предыдущую метку
      mapObj.geoObjects.remove(placeMark);
    }

	// добавить новую метку
    placeMark = new ymaps.Placemark(
            [p.latitude, p.longitude],
            {
              content: p.text,
              balloonContent: '<div class="alt-font f14">'+p.text+'</div>'
            },
            {preset: 'twirl#redDotIcon'}
            );

     mapObj.geoObjects.add(placeMark);

		// отценторвать карту по координатам метки
     mapObj.setCenter([p.latitude, p.longitude], 16);
		 */
		 // end yandex maps

  };

  // клик на ссылку
  var linkClick = function (coordLink) {

	// не выполнять действий с выбранной ссылкой
    if (coordLink.selected) {
      return;
    };

	// отменить выделение предыдущей ссылки
    if (curCoordLink) {
      curCoordLink.unSelect();
    }
    // сделать выбранной текущую ссылку
    coordLink.select();
    curCoordLink = coordLink;

	// установить метку по координатам ссылки
    setMapMark({
      latitude: coordLink.latitude,
      longitude: coordLink.longitude,
      //text: coordLink.title + '<br />' + coordLink.addr // текст метки
			text: coordLink.title
    });

  };

	// перерисовать карту при изменении размеров окна
	var reCenterMap = function () {

    if (!mapObj) {return;};

		google.maps.event.trigger(mapObj, "resize");

		if (placeMark) {
			mapObj.setCenter(placeMark.getPosition());
		} else {
			mapObj.setCenter(new google.maps.LatLng(56.011073,92.866723));
		};

	};

  // инициализация ссылок
  remix.mapOnStartPage.init = function (mapOptions) {

		// создать карту
		mapObj = new google.maps.Map(mapCnt, mapOptions);

    var links = $(p.linksCnt).find('div.sp-address-item-highlight'); // блоки-ссылки
    var coordLinkObj;
    var cssActiveClass = 'sp-address-item-highlight-on'; // класс выбранной сслыки

    links.each(function(){

      var crnt = $(this);
      // создать объекты ссылок
      coordLinkObj = new coordLink({
        jqNode: crnt,
        cssActiveClass: cssActiveClass,
        onClickCallback: linkClick
      });

      // если есть ссылка с классом выбранного состояния, установить метку по её координатам
      if (crnt.hasClass(cssActiveClass)) {
        linkClick(coordLinkObj);
      };

    });

		remix.win.addResizeFunction(reCenterMap);

  };

  // при загрузке скриптов яндекс-карты
	/*
  ymaps.ready(function () {
  // создать карту
        mapObj = new ymaps.Map("sp-map", {
            center: [56.011073, 92.866723],
            zoom: 15
        });
	// создать ссылки
        init();
    });
*/

	var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=remixMapOnStartPageInit";
  document.body.appendChild(script);


};

// remix.mapOnStartPage
// инициализация карты на стартовой странице
function remixMapOnStartPageInit() {

	// "серая" карта (цвета без насыщенности)
	var mapStyle = [
		{
			featureType: "road.arterial",
			stylers: [{ saturation: -75 }]
		},
		{
			featureType: "road.highway",
			stylers: [{ saturation: -75 }]
		},
		{
			featureType: "transit.line",
			stylers: [{ saturation: -60 }]
		}
		];

  var mapOptions = {
    zoom: 17,
    center: new google.maps.LatLng(56.011073,92.866723),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
		disableDefaultUI: true,
		scrollwheel: false,
    draggable: false,
		styles: mapStyle
  };

	// проинициализировать ссылки
	remix.mapOnStartPage.init(mapOptions);
};

// форма подписки на журнал
remix.magsubscribeform = function () {

	// форма для подписки на бумажную версию
	var magSubsFormPaper = document.getElementById('mag-subs-form-paper');
	// форма для подписки на электронную версию
	var magSubsFormDigital = document.getElementById('mag-subs-form-digital');

	if (!magSubsFormPaper || !magSubsFormDigital) {
		return;
	};

	magSubsFormPaper = $(magSubsFormPaper);
	magSubsFormDigital = $(magSubsFormDigital);

	// валидация формы подписки на бумажную версию
	var validatorPaper = magSubsFormPaper.validate({

     rules: {
       name: {required: true}, // имя и фамилия
       email: {required: true, email: true}, // электронная почта
       addres: {required: true} // адрес
     },

     messages: {
       name: 'Не указаны имя и фамилия',
       email: 'Неправильный адрес электронной почты',
       addres: 'Не указан адрес доставки'
     },

     errorClass: 'f-error', // css-класс сообщений об ошибках

     // запретить срабатывание валидации при вводе данных в поле
     onkeyup:function(){
     },

     // запретить срабатывание валидации при вводе данных в поле
     onfocusout:function(){
     }

	});

	// валидация формы подписки на электронную версию
	var validatorDigital = magSubsFormDigital.validate({

     rules: {
       name: {required: true}, // имя и фамилия
       email: {required: true, email: true} // электронная почта
     },

     messages: {
       name: 'Не указаны имя и фамилия',
       email: 'Неправильный адрес электронной почты'
     },

     errorClass: 'f-error', // css-класс сообщений об ошибках

     // запретить срабатывание валидации при вводе данных в поле
     onkeyup:function(){
     }

	 });

	 // переключатель блоков бумажной подписки
	 var paperToggler = new remix.simpleBlockSwitch({
		 blocks: [$('#mag-subs-form-paper')],
		 showed: true
	 });

	 // переключатель блоков электронной подписки
	 var digitalToggler = new remix.simpleBlockSwitch({
		 blocks: [$('#mag-subs-form-digital-remark'),$('#mag-subs-form-digital')]
	 });

	 // переключить отображение форм бумажной и электронной подписок
	 var toggleForms = function(elem) {

		 // предотвратить потвторное срабатывание при клике на уже выбранную кнопку
		 if (!elem.hasClass('btn-sw-sel')) {return;}

		 if (paperToggler.showed) {
				paperToggler.hide();
				digitalToggler.show();
				return;
			}

		 if (digitalToggler.showed) {
				digitalToggler.hide();
				paperToggler.show();
				return;
			}

	 };

	// изменить вид кнопки и выполнить преключение блоков
	 new remix.blockAccentSwitcher({
		 context: $('#mag-subs-form-select'),
		 matchClass: 'btn-sw',
		 elementToAccentClass: 'btn-sw',
		 accentedStateClass: 'btn-sw-sel',
		 alreadyAccentedStateQuery: 'a.btn-sw-sel',
		 callback: toggleForms
	 });


};

// форма обратной связи
remix.feedBackForm = function () {

  var feedbackFormPreCnt = $('#feedback-form-pre'); // контейнер приглашения формы
  var feedBackForm = $('#feedback-form'); // форма

  // блок сообщения об отправке отзыва
  var feedBackSuccess = $('<div class="feedback-form-success ib ml20 na">Спасибо! Ваш отзыв принят.</div>');
  $('#feedback-form-sbmt-cnt').append(feedBackSuccess);

    // произошла успешная отправка формы с подтверждением от сервера
  feedBackForm.on('ajax:success', function() {
    feedBackSuccess.removeClass('na'); // показать сообщение об отправке отзыва
  })

	// валидация формы подписки на электронную версию
	var validator = feedBackForm.validate({

     rules: {
       "feedback[name]": {required: true}, // имя и фамилия
       "feedback[email]": {required: true, email: true}, // электронная почта
       "feedback[text]": {required: true} // текст отзыва
     },

     messages: {
       "feedback[name]": 'Не указано имя',
       "feedback[email]": 'Неправильный адрес электронной почты',
       "feedback[text]": 'Нет отзыва'
     },

     errorClass: 'f-error', // css-класс сообщений об ошибках

     // запретить срабатывание валидации при вводе данных в поле
     onkeyup:function(){
     },

      submitHandler: function(form) {
      if (validator.valid()) {
        feedBackSuccess.removeClass('na'); // показать сообщение об отправке отзыва
        //form.submit();
      }

     }

	 });

  var onOpen = function () {
    feedBackForm.addClass('nl-top-message-off-shadow');
    feedbackFormPreCnt.slideUp();
  };

  var onClose = function () {
    feedBackForm.addClass('nl-top-message-off-shadow');
    feedbackFormPreCnt.slideDown();
  };

  var afterShow = function () {
    feedBackForm.removeClass('nl-top-message-off-shadow');
  };

  // ссылка открытия/скрытия формы
  new remix.heightSlideBlockActor({
    jqNode: $('#feedback-form-pre-open-link'), // ссылка
    onClose: onClose,
    onOpen: onOpen,
    toggledBlockCloseElement: 'span.f-close-cross', // элемент внутри формы для её закрытия
    heightSlideBlockParams: {
      block: $('#feedback-form-hsb'), // обёртка формы
      contentBlock: feedBackForm, // форма
      afterShow: afterShow
    }
  });

};
// end remix.feedBackForm

// выпадающее меню «О компании»
remix.aboutDropDown = function () {

  var link = $('#about-drop-down-link');
  var cnt = $('#about-drop-down-cnt');

  var timer = false;

  var linkleave = function () {
    cnt.stop().fadeOut(250);
  };

	if (!remix.isTouch) {

		link.bind('mouseenter',function(){
			cnt.stop().hide().fadeIn(250);
		});

		cnt.bind('mouseenter',function(){
			if (timer) {
				clearTimeout(timer);
				timer = false;
				cnt.stop().css('opacity',1).show();
			}
		});

		cnt.bind('mouseleave',linkleave);

		link.bind('mouseleave',function(){
			timer = setTimeout(linkleave, 200);
		});

		return;

	};

	if (remix.isTouch) {
		link.bind('click',function(){
			cnt.fadeToggle(250);
		});
	};




};
// remix.aboutDropDown

/**
 * Example: inputPlaceholder( document.getElementById('my_input_element') )
 * @param {Element} input
 * @param {String} [color='#AAA']
 * @return {Element} input
 */
remix.inputPlaceholder = function (input, color) {

	if (!input) return null;

	// Do nothing if placeholder supported by the browser (Webkit, Firefox 3.7)
	if (input.placeholder && 'placeholder' in document.createElement(input.tagName)) return input;

	color = color || '#AAA';
	var default_color = input.style.color;
	var placeholder = input.getAttribute('placeholder');

	if (input.value === '' || input.value == placeholder) {
		input.value = placeholder;
		input.style.color = color;
		input.setAttribute('data-placeholder-visible', 'true');
	}

	var add_event = /*@cc_on'attachEvent'||@*/'addEventListener';

	input[add_event](/*@cc_on'on'+@*/'focus', function(){
	 input.style.color = default_color;
	 if (input.getAttribute('data-placeholder-visible')) {
		 input.setAttribute('data-placeholder-visible', '');
		 input.value = '';
	 }
	}, false);

	input[add_event](/*@cc_on'on'+@*/'blur', function(){
		if (input.value === '') {
			input.setAttribute('data-placeholder-visible', 'true');
			input.value = placeholder;
			input.style.color = color;
		} else {
			input.style.color = default_color;
			input.setAttribute('data-placeholder-visible', '');
		}
	}, false);

	input.form && input.form[add_event](/*@cc_on'on'+@*/'submit', function(){
		if (input.getAttribute('data-placeholder-visible')) {
			input.value = '';
		}
	}, false);

	return input;
}


// эмуляция input placeholder
remix.inputPlaceHolders = function () {

	if (!('placeholder' in document.createElement('input'))) {
		$('input[placeholder], textarea[placeholder]').each(function(){
			remix.inputPlaceholder($(this)[0]);
		});
		}
};
// remix.aboutDropDown

// document ready
$(function() {

  var doc = $(document);

  // выпадающий список "о компании"
  remix.aboutDropDown();
  // блоки прокрутки с кристаллом
  remix.initGemScrolls({container:doc});
  // блоки слайдеров на ширину страницы
  remix.wideSlidersOnPage({container:doc});
  // слайдер акций на главной
  remix.actionsSliderOnMain();
  // просмотр больших фото изделий из коллекций в всплывашке
  remix.GoodsGridFullViewsManager({container:$('#goods-grids')});
  // ссылки скрывающие/раскрывающие выпадающие блоки
  remix.heightSlideBlockLinks({container:doc});
  // ссылки показывающие скрытые элементы фотогалей
  remix.photoGridLinks({container:doc});
  // лайтбокс для просмотра фото
  remix.magnificPopupGalleryOnPage({container:doc});
  // прилипающее верхнее меню
  remix.stickyTopMenu();
	// эмуляция input placeholder
	remix.inputPlaceHolders();
	// прокрутка новостей на главной
	remix.startNewsScroll();
  // карта на стартовой странице
  remixMapOnStartPage = remix.mapOnStartPage({
    mapCntId: 'sp-map',
    linksCnt: $('#sp-address-list')
  });

});
// end document ready