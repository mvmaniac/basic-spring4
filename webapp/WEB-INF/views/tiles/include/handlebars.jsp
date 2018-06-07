<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>

<!-- handlebars template -->
<script id="replyList-template" type="text/x-handlebars-template">
    {{#each .}}
        <li class="replyLi" data-rno={{rno}}>
            <i class="fa fa-comments bg-blue"></i>
            <div class="timeline-item">
        <span class="time">
        <i class="far fa-clock"></i>&nbsp;{{prettifyDate regdate}}
        </span>
                <h3 class="timeline-header"><strong>{{rno}}</strong>&nbsp;-&nbsp;{{replyer}}</h3>
                <div class="timeline-body">{{replytext}}</div>
                <div class="timeline-footer">
                    <a class="btn btn-default btn-sm" data-toggle="modal" data-target="#modifyModal">Modify</a>
                </div>
            </div>
        </li>
    {{/each}}
</script>

<script id="pagination-template" type="text/x-handlebars-template">
    {{#if showFirst}}
        <li class="page-item"><a class="page-link" href="#" data-page="1">처음</a></li>
    {{/if}}

    {{#if showPrevMore}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{prevMorePage}}">&laquo;</a></li>
    {{/if}}

    {{#if showPrev}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{prevPage}}">&lt;</a></li>
    {{/if}}

    {{#forPaging startPage endPage 1 selectPage}}
        <li class="page-item {{#equals this.index this.select 'active' ''}}{{/equals}}">
            <a class="page-link" href="#" data-page="{{this.index}}">{{this.index}}</a>
        </li>
    {{/forPaging}}

    {{#if showNext}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{nextPage}}">&gt;</a></li>
    {{/if}}

    {{#if showNextMore}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{nextMorePage}}">&raquo;</a></li>
    {{/if}}

    {{#if showLast}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{totalPageCount}}">마지막</a></li>
    {{/if}}
</script>