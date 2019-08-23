<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Marcas - Homework</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div class="w-100 d-flex justify-content-center">
    <form>
        <div class="form-group">
            <label for="nombreArticulo">Nombre</label>
            <input type="text" class="form-control" id="nombreArticulo" aria-describedby="nombreArticuloHelp" placeholder="${articulos.name}">
        </div>
        <div class="form-group">
            <label for="picture">Imagen</label>
            <input type="text" class="form-control" id="picture" placeholder="${articulos.picture}">
        </div>
        <div class="form-group">
            <label for="cantidadItems">Items</label>
            <input type="text" class="form-control" id="cantidadItems" placeholder="${articulos.total_items_in_this_category}">
        </div>
        <button type="submit" class="btn btn-primary" @click="editar(category.finalCategory)">Aceptar</button>
        <button type="submit" class="btn btn-primary" @click="cancelarArticulo(category.finalCategory)">Cancelar</button>
    </form>
</div>

</body>
</html>