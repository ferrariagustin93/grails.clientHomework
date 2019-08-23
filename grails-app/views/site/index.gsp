<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Marcas - Homework</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>


<select name="selectMarca" onchange="category.fetchData(this.value)" >
    <g:each in="${marcas}" var="marca">
        <option value="${marca?.id}">${marca.name}</option>
        <br>
    </g:each>
</select>

<div id="category" class="d-flex flex-column justify-content-center">

    <div style="width: 100%;" class="justify-content-center">
        <table border="1">
            <thead>
            <tr>
                <td class="text-center">Id</td>
                <td class="text-center">Name</td>
            </tr>
            </thead>
            <tr v-for="category in listaCategory">
                <td class="text-center"><a href="#" @click="getArticulo(category.id)">{{ category.id }}</a></td>
                <td class="text-center">{{ category.name }}</td>
            </tr>
        </table>
    </div>


    <div class="w-100 d-flex justify-content-center" >
        <button class="btn-primary" id="Agregar" @click="addArticulo()">Agregar</button>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" >
                    <h4 class="modal-title">CATEGORIA: {{ category.finalCategory.name }}</h4>
                </div>
                <div class="modal-body">
                    <p>Id: <strong>{{category.finalCategory.id}}</strong> .</p>
                    <p>Name: <strong>{{category.finalCategory.name}}</strong> .</p>
                    <p>Imagen: <a id="myImageHref"><img id="myImage" height="100" width="100"></a></p>
                    <p>Cantidad de items: <strong>{{category.finalCategory.total_items_in_this_category}}</strong> .</p>
                </div>
                <div class="modal-footer">
                    </button>
                    <button class="btn-danger" id="Eliminar" @click="deleteArticulo(category.finalCategory)">Eliminar</button>
                    <button class="btn-secondary" id="Editar" @click="editArticulo(category.finalCategory)">Editar</button>
                </div>
            </div>

        </div>
    </div>



</div>





<script>

    var category = new Vue({
        el:'#category',
        data: {
            listaCategory: [],
            finalCategory: []
        },
        methods: {
            fetchData: function (idSite) {
                axios.get('/site/getArticulos', {
                    params: {
                        id:idSite
                    }
                }).then(function (response) {
                    category.listaCategory = response.data.articulos;

                }).catch(function (error) {
                    console.log(error);
                })
            },
            fetchDataCategory: function (idArticulo) {
                axios.get('/site/getChildrenArticulos', {
                    params: {
                        id:idArticulo
                    }
                }).then(function (response) {
                    category.listaCategory = response.data.articulos.children_categories;
                    if(category.listaCategory.length == 0) {
                        category.finalCategory = response.data.articulos;
                        showModal();
                        showImage();
                    }

                }).catch(function (error) {
                    console.log(error);
                })
            },
            fetchDataEditCategory: function (idArticulo) {
                axios.get('/site/edit', {
                    params: {
                        id:idArticulo
                    }
                }).then(function (response) {

            }).catch(function (error) {
                    console.log(error);
            })
            }
        }
    })

    function editArticulo(articulo) {
        //category.fetchDataEditCategory(articulo.id);
        window.open(
            'http://localhost:8080/site/edit?id='+articulo.id,
            '_blank'
        );
    }

    function getArticulo(idArticulo) {
        category.fetchDataCategory(idArticulo);
    }

    function showModal() {
        $(document).ready(function(){
            // Show the Modal on load
            $("#myModal").modal("show");

            // Hide the Modal
            $("#myBtn").click(function(){
                $("#myModal").modal("hide");
            });
        });
    }

    function showImage() {
        $(document).ready(function(){
            document.getElementById('myImage').src=category.finalCategory.picture;
            document.getElementById('myImageHref').href=category.finalCategory.picture;

        });
    }

    function showPath(path) {
        alert(path.length);
    }





</script>
</body>
</html>