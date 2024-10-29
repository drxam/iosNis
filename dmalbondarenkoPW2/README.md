• Question: What issues prevent us from using storyboards in real projects?
Ответ: при использовании сторибордов могут возникнуть проблемы с контролем версий: т.к. сториборды представляются в виде xml файлов, отследить изменения в структуре сториборда очень сложно. Также сториборды может быть неудобно использовать в крупных проектах со множеством экраном из-за веротяности слияния кода или снижения производительности


• Question: What does the code on lines 25 and 29 do?
Ответ: в строке 25 свойство translatesAutoresizingMaskIntoConstraints = false объекта title отключает автоматическое создание constraints с использованием frame (старый способ), что позволяет использовать auto-layout и точнее насраивать привязку объектов.
    в строке 29 в иерархию представлений к основному view добавляется subview title, а само view становится superview для title
    

• Question: What is a safe area layout guide?
Ответ: safe area layout guide - это зона на экране, где можно безопасно размещать объекты, не боясь перекрытия с челкой, dynamic island'ом или областью для жестов


• Question: What is [weak self] on line 23 and why it is important?
Ответ: [weak self] используется для создания слабой ссылки на self внутри замыкания, чтобы избежать сильной ссылки и циклической зависимости между замыканием и объектом, которое это замыкание содержит, что важно для предотвращения утечек памяти


• Question: What does clipsToBounds mean?
Ответ: clipsToBounds используется для обрезания subviews по контуру своего superview в случае если они выходят за его пределы, например если квадратная картинка вставляется в view с закругленными углами


• Question: What is the valueChanged type? What is Void and what is Double?
Ответ: valueChanged - замыкание, которое принимает параметр типа Double (новое значение слайдера) и возвращает Void (не возвращает значения)
