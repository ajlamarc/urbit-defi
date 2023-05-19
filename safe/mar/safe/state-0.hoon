/-  *safe
=/  state-0
  $:  =safes
      =address-book
      =cookies
      =session
      =settings
  ==
=,  enjs:format
|_  stat=state-0
++  grab
  |%
  ++  noun  state-0
  --
++  grow
  |%
  ++  noun  stat
  ++  json  (make-state-object stat)
  ++  make-state-object
    |=  stat=state-0
    %-  pairs
    :~  
        'addedSafes'^(parse-added-safes safes.stat)
        'addressBook'^(parse-address-book address-book.stat)
        'cookies'^(parse-cookies cookies.stat)
        'session'^(parse-session session.stat)
        'settings'^(parse-settings settings.stat)
    ==
  ++  parse-settings
    |=  setg=settings
    %-  pairs
    :~  'currency'^s/currency.setg
        [%'shortName' (parse-shortname shortname.setg)]
        'theme'^o/(~(run by theme.setg) (lead %b))
    ==
  ++  parse-shortname
    |=  short=[copy=? qr=? show=?]
    %-  pairs
    :~  'copy'^b/copy.short
        'qr'^b/qr.short
        'show'^b/show.short
    ==
  ++  parse-cookies
    |=  cook=cookies
    %-  pairs
    :~  'updates'^b/updates.cook
        'necessary'^b/necessary.cook
        'analytics'^b/analytics.cook
    ==
  ++  parse-added-safes
    |=  =safes
    :-  %o
    %-  ~(run by safes)
    |=  safe=(map @t [@ud @t (list @t)])
    :-  %o
    %-  ~(run by safe)
    |=  [thresh=@ud ethebal=@t owners=(list @t)]
    %-  pairs
    :~  'ethBalance'^s/ethebal
        'threshold'^(numb thresh)
        'owners'^a/(turn owners :(corl (cury frond %value) ^json (lead %s)))
    ==  
  ::
  ++  parse-address-book
    |=  book=address-book
    :-  %o
    %-  ~(run by book)
    |=(buk=(map @t @t) o/(~(run by buk) (lead %s))) 
  ::
  ++  parse-session
    |=  s=session
    %-  pairs
    :~  'lastChainId'^s/-.s
        'lastSafeAddress'^o/(~(run by +.s) (lead %s))
    ==
  --
++  grad  %noun
--