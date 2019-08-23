<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Sitios de MELI</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>


<select name="selectSite" onchange="category.fetchData(this.value)" >
    <g:each in="${sites}" var="site">
        <option value="${site?.id}">${site.name}</option>
        <br>
    </g:each>
</select>

<div id="category">
    <table border="1">
        <thead>
        <tr>
            <td>Id</td>
            <td>Name</td>
        </tr>
        </thead>
        <tr v-for="category in listaCategory">
            <td><a href="#" @click="getCategories(category.id)">{{ category.id }}</a></td>
            <td>{{ category.name }}</td>
        </tr>
    </table>


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
                    <p>Imagen: <a id="myImageHref"><img id="myImage" height="60" width="60"></a></p>
                    <p>Cantidad de items: <strong>{{category.finalCategory.total_items_in_this_category}}</strong> .</p>
                </div>
            </div>

        </div>
    </div>

    <!-- Path -->
    <div id="path">
        <span v-for="category in listaCategory" >
            <a href="#" @click="showPath(category)">
                {{ category }}
            </a>
        </span>
    </div>
</div>



<script>

    var category = new Vue({
        el: '#category',
        data: {
            listaCategory: [],
            finalCategory: []
        },
        methods: {
            fetchData: function (idSite) {
                axios.get('/site/getCategory', {
                    params: {
                        idSite:idSite
                    }
                }).then(function (response) {
                    category.listaCategory = response.data.categories;

                }).catch(function (error) {
                    console.log(error);
                })
            },
            fetchDataCategory: function (idCategory) {
                axios.get('/site/getChildrenCategory', {
                    params: {
                        idCategory:idCategory
                    }
                }).then(function (response) {
                    category.listaCategory = response.data.childrenCategories.children_categories;
                    showPath(response.data.childrenCategories.path_from_root)
                    if(category.listaCategory.length == 0) {
                        category.finalCategory = response.data.childrenCategories;
                        showModal();
                        showImage();
                    }

                }).catch(function (error) {
                    console.log(error);
                })
            }
        }
    })

    function getCategories(idCategory) {
        category.fetchDataCategory(idCategory);
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
        alert(path.length)
    }




</script>
</body>
</html>