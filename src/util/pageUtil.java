package util;

import entity.page;

/**
 * Created by lazier on 2015/10/26 0026.
 */
public class pageUtil {
    public static page createPage(int everyPage,int totalCount,int currentPage) {// 1.ÿҳ��ʾ����(everyPage)
        everyPage = getEveryPage(everyPage);
        currentPage = getCurrentPage(currentPage);
        int totalPage = getTotalPage(everyPage, totalCount);
        int beginIndex = getBeginIndex(everyPage, currentPage);
        boolean hasPrePage = getHasPrePage(currentPage);
        boolean hasNextPage = getHasNextPage(totalPage, currentPage);
        return new page(everyPage, totalCount, totalPage, currentPage,
                beginIndex, hasPrePage,  hasNextPage);
    }

    public static page createPage(page page,int totalCount) {
        int everyPage = getEveryPage(page.getEveryPage());
        int currentPage = getCurrentPage(page.getCurrentPage());
        int totalPage = getTotalPage(everyPage, totalCount);
        int beginIndex = getBeginIndex(everyPage, currentPage);
        boolean hasPrePage = getHasPrePage(currentPage);
        boolean hasNextPage = getHasNextPage(totalPage, currentPage);
        return new page(everyPage, totalCount, totalPage, currentPage,
                beginIndex, hasPrePage,  hasNextPage);
    }

    //����ÿҳ��ʾ��¼��
    public static int getEveryPage(int everyPage) {
        return everyPage == 0 ? 10 : everyPage;
    }

    //���õ�ǰҳ
    public static int getCurrentPage(int currentPage) {
        return currentPage == 0 ? 1 : currentPage;
    }

    //������ҳ��,��Ҫ�ܼ�¼����ÿҳ��ʾ����
    public static int getTotalPage(int everyPage,int totalCount) {
        int totalPage = 0;
        if(totalCount % everyPage == 0) {
            totalPage = totalCount / everyPage;
        } else {
            totalPage = totalCount / everyPage + 1;
        }

        return totalPage;
    }

    //������ʼ�㣬��Ҫÿҳ��ʾ���٣���ǰҳ
    public static int getBeginIndex(int everyPage,int currentPage) {
        return (currentPage - 1) * everyPage;
    }

    //�����Ƿ�����һҳ����Ҫ��ǰҳ
    public static boolean getHasPrePage(int currentPage) {
        return currentPage == 1 ? false : true;
    }

    //�����Ƿ�����һ������Ҫ��ҳ���͵�ǰҳ
    public static boolean getHasNextPage(int totalPage, int currentPage) {
        return currentPage == totalPage || totalPage == 0 ? false : true;
    }

}
