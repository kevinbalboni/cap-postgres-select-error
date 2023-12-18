using {sap.capire.bookshop as my} from '../db/schema';
service WispinService @(impl : './service.js')@(path : '/odata/MyService') {

  entity Books as projection on my.Books;
  entity Authors as projection on my.Authors;
}