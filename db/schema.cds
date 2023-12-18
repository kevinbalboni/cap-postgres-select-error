using {
    cuid,
    Currency,
    managed,
    sap
} from '@sap/cds/common';

namespace sap.capire.bookshop;

entity Books : managed {
    key ID       : Integer;
        title    : localized String(111);
        descr    : localized String(1111);
        author   : Association to Authors;
        genre    : Association to Genres;
        stock    : Integer;
        price    : Decimal;
        currency : Currency;
        image    : LargeBinary @Core.MediaType: 'image/png';
}

entity Authors : managed {
    key ID           : Integer;
        name         : String(111);
        dateOfBirth  : Date;
        dateOfDeath  : Date;
        placeOfBirth : String;
        placeOfDeath : String;
        books        : Association to many Books
                           on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
    key ID       : Integer;
        parent   : Association to Genres;
        children : Composition of many Genres
                       on children.parent = $self;
}


entity UIElements2UIAggregations {
    key uiElement     : Association to UIElements not null     @assert.target;
    key uiAggregation : Association to UIAggregations not null @assert.target;
};

entity UIElements : managed {
    key name           : String(100) not null;
    key version        : String(15) not null;
        description    : LargeString;
        class          : String(100);
        extends        : String(100);
        implements     : LargeString;
        icon           : String(100);
        isEnabled      : Boolean;
        uiAggregations : Association to many UIElements2UIAggregations
                             on uiAggregations.uiElement = $self;
}

entity UIAggregations : cuid, managed {
    name            : String(100) not null;
    description     : LargeString;
    expectedClass   : String(100);
    altClass        : String(100);
    isEnabled       : Boolean;
    isUIContainer   : Boolean;
    isBindable      : Boolean;
    containerTypes  : array of String;
    getter          : String(100);
    setter          : String(100);
    addMethod       : String(100);
    removeMethod    : String(100);
    removeAllMethod : String(100);
    uiElements      : Association to many UIElements2UIAggregations
                          on uiElements.uiAggregation = $self;
}
