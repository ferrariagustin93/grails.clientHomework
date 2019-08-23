package com.mercadolibre.itacademy.grails

import grails.converters.JSON
import groovy.json.JsonSlurper

class SiteController {

    def indexOld() {
        def url = new URL("https://api.mercadolibre.com/sites");
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def sites = json.parse(connection.getInputStream());
        [sites:sites]
    }

    def index() {
        def url = new URL("http://localhost:8081/marcas");
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def marcas = json.parse(connection.getInputStream());
        [marcas:marcas]

    }

    def getCategory(String idSite) {
        print(idSite);
        String urlSite = "https://api.mercadolibre.com/sites/"+idSite+"/categories";
        def url = new URL(urlSite);
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def categories = json.parse(connection.getInputStream());
        def resultado = [categories:categories]
        render resultado as JSON
    }

    def getChildrenCategory(String idCategory) {
        println("IdCategory"+idCategory);
        String urlSite = "https://api.mercadolibre.com/categories/"+idCategory;
        def url = new URL(urlSite);
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def childrenCategories = json.parse(connection.getInputStream());
        def resultado = [childrenCategories:childrenCategories]
        render resultado as JSON
    }

    def getArticulos(String id) {
        String urlSite = "http://localhost:8081/marcas/"+id+"/articulos";
        def url = new URL(urlSite);
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def articulos = json.parse(connection.getInputStream());
        def resultado = [articulos:articulos]
        render resultado as JSON
    }

    def getChildrenArticulos(String id) {
        String urlSite = "http://localhost:8081/articulos/"+id;
        def url = new URL(urlSite);
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def articulos = json.parse(connection.getInputStream());
        def resultado = [articulos:articulos]
        render resultado as JSON
    }

    def edit(String id) {
        String urlSite = "http://localhost:8081/articulos/"+id;
        def url = new URL(urlSite);
        def connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper();
        def articulos = json.parse(connection.getInputStream());
        [articulos:articulos]

    }
}
